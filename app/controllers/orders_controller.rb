class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_order_owner, only: [:ship, :confirm]

  def new
    @order = current_user.bought_orders.build if current_user.present?
  end

  def create
    product = current_cart.line_items.first.product
    unless current_user.can_buy?(product)
      return redirect_to :back, flash: { error: controller_translate("can_not_buy") }
    end
    @order = current_user.bought_orders.build(order_params)
    @order.add_items_from_cart(current_cart)
    @order.seller_id = current_cart.line_items.first.product.user.id
    @order.province_id = params[:order][:province]
    @order.city_id = params[:order][:city]
    @order.district_id = params[:order][:district]
    if @order.save
      # mark the product is sold
      product.update(sold: true)
      redirect_to checkout_path(@order)
    else
      redirect_to :back
    end
  end

  def checkout
    @order = Order.find(params[:id])
  end

  def ship
    @order.ship if @order.present?
    respond_to do |format|
      format.html
      format.js { render "update_order_item", layout: false }
    end
  end

  def confirm
    @order.confirm if @order.present?
    respond_to do |format|
      format.html
      format.js { render "update_order_item", layout: false }
    end
  end

  def inspect
    key_id, amount = params[:key_id], params[:amount]
    OrderInspector.delay.inspect(key_id, amount)
  end

  private
    def order_params
      params.require(:order).permit(:receiver_name, :street)
    end

    def check_order_owner
      @order = Order.find_by(identifier: params[:id])
      return if current_user.blank? || current_user != @order.seller
    end
end
