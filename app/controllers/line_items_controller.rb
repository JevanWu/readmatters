class LineItemsController < ApplicationController

  def create
    product = Product.find(params[:product_id])

    current_cart.clear
    @line_item = current_cart.add_product(product)

    if @line_item.save
      redirect_to new_order_path
    else
      redirect_to root_path
    end

    # respond_to do |format|
    #   if @line_item.save
    #     @current_item = @line_item
        #format.js { render "create", layout: false }
    #   else
    #     format.html { redirect_to root_path }
    #   end
    # end
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
