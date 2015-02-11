class OrdersController < ApplicationController

  def new
    @order = current_user.orders.build if current_user.present?
  end

  def create
    @order = Order.create(order_params)
    if clean_cart && set_buyer
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
      params.require(:order).permit(:receiver_name, :province_id, :city_id, :district_id, :street, :user_id)
    end

    def clean_cart
      current_cart.line_items.each do |item|
        item.order = @order
        item.cart = nil
        item.save
      end
    end

    def set_buyer
      @order.receiver_id = current_user.id
      @order.save
    end
end
