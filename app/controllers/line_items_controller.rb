class LineItemsController < ApplicationController

  def create
    product = Product.find(params[:product_id])
    @line_item = current_cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        @current_item = @line_item
        format.js { render "create", layout: false }
      else
        format.html { redirect_to root_path }
      end
    end
  end

  def destroy
    product = Product.find(params[:product_id])

    respond_to do |format|
      if current_cart.remove_product(product)
        format.js { render "create", layout: false }
      else
        format.html { redirect_to root_path }
      end
    end
  end
end
