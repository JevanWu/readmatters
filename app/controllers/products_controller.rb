require 'nokogiri'
require 'open-uri'

class ProductsController < ApplicationController

  def new
    redirect_to douban_link_products_path if params[:douban_link].nil?
    
    @product = Product.new
    doc = Nokogiri::HTML(open(params[:douban_link]).read)
    @name = doc.css('h1 span').first.content
    @description = doc.css('#link-report .intro').last.content
    @kind = doc.css('#db-tags-section .indent a').first.content
  end

  def create
    @product = Product.create(product_params)
    redirect_to product_path(@product)
  end

  def show
    @product = Product.find(params[:id])
  end

  def douban_link
  end

  private

    def product_params
      params.require(:product).permit(:name, :kind, :cover, :price, :description)
    end
end
