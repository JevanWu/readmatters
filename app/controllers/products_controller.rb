require 'nokogiri'
require 'open-uri'

class ProductsController < ApplicationController

  def new
    @product = Product.new
    if !params[:douban_link].nil?
      redirect_to new_product_path and return unless params[:douban_link].present?
      doc = Nokogiri::HTML(open(params[:douban_link]).read)
      @name = doc.css('h1 span').first.content
      @description = doc.css('#link-report .intro').last.content
      @kind = doc.css('#db-tags-section .indent a').first.content
    end
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
    respond_to do |format|
      format.js { render "generate_book_info", layout: false }
    end
  end

  private

    def product_params
      params.require(:product).permit(:name, :kind, :price, :description)
    end
end
