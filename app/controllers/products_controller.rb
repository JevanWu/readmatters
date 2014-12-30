class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    redirect_to product_path(@product)
  end

  def show
    @product = Product.find(params[:id])
  end

  private

    def product_params
      params.require(:product).permit(:name, :kind, :price, :description, :book_link)
    end
end
