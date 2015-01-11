require 'nokogiri'
class ProductsController < ApplicationController

  def new
    @product = Product.new
    respond_to do |format|
      format.js { render "new", layout: false }
      format.html { render "new" }
    end
  end

  def create
    @product = Product.create(product_params)
    redirect_to product_path(@product)
  end

  def show
    @product = Product.find(params[:id])
  end

  def generate_book_info
    # doc = Nokogiri::HTML(open(params[:douban_link]))
    # @description = doc.css('#link-report .intro').last.content
    #@product = Product.new
  end

  private

    def product_params
      params.require(:product).permit(:name, :kind, :price, :description)
    end
end
