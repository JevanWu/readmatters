class LineItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params[:product_id])

    @line_item = current_cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        @current_item = @line_item
        format.js { render "create", layout: false }
        format.html { redirect_to cart_path }
      else
        format.html { redirect_to root_path }
      end
    end
  end

  def destroy
    product = Product.find(params[:id])
    current_cart.remove_product(product)

    respond_to do |format|
      format.js { render "create", layout: false }
      format.html { redirect_to cart_path(current_cart) }
    end
  end
end
