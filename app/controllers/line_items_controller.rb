class LineItemsController < ApplicationController

  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        @current_item = @line_item
        format.js { render "create", layout: false }
      else
        format.html { redirect_to root_path }
      end
    end
  end
end
