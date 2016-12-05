class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_order_owner, only: [:ship, :confirm]

  def new
    @order = current_user.bought_orders.build if current_user.present?
    @seller_id = params[:seller_id]
    @line_items = current_cart.line_items.eager_load(:product).where("products.user_id = ? and products.status = ?", @seller_id, "normal")
  end

  def create
    @order = current_user.bought_orders.build(order_params)
    @order.add_items_from_cart(current_cart, params[:order][:seller_id])
    if @order.line_items.blank?
      return redirect_to :back, flash: { error: controller_translate("can_not_buy") }
    end
    @order.seller_id = params[:order][:seller_id]
    @order.province_id = params[:order][:province]
    @order.city_id = params[:order][:city]
    @order.district_id = params[:order][:district]
    if @order.save
      redirect_to checkout_path(@order)
    else
      redirect_to :back
    end
  end

  def checkout
    @order = Order.find(params[:id])
    redirect_to :back if !@order.wait_pay?
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
    pay_code, amount = params[:pay_code], params[:amount]
    OrderInspector.delay.inspect(pay_code, amount)
  end

  def bought_orders
    @orders = current_user.bought_orders
    render "index"
  end

  def sold_orders
    @orders = current_user.sold_orders
    render "index"
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
