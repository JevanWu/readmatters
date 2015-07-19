class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = current_user.bought_orders.build if current_user.present?
  end

  def create
    @order = current_user.bought_orders.build(order_params)
    @order.add_items_from_cart(current_cart)
    @order.seller_id = current_cart.line_items.first.product.user.id
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
  end

  private
    def order_params
      params.require(:order).permit(:receiver_name, :street)
    end
end
