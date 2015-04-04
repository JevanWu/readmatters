require 'nokogiri'
require 'open-uri'

class ProductsController < ApplicationController

  def new
    redirect_to book_name_products_path if params[:douban_link].nil?
    
    @product = Product.new
    doc = Nokogiri::HTML(open(params[:douban_link]).read)
    if params[:douban_link].match /read.douban.com/
      @name = doc.css(".article-title").first.content
      @cover_url = doc.css(".cover img").first['src']
      @description = doc.css(".abstract-full .info p").map{|element| element.content}
                                                      .inject{|sum, element| sum + "/n" + element}
      @kind = "Instance"
    elsif params[:douban_link].match /book.douban.com/
      @name = doc.css('h1 span').first.content
      @cover_url = doc.css('.nbg img').first['src']
      @description = doc.css('#link-report .intro').last.content
      @kind = doc.css('#db-tags-section .indent a').first.content
    end
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to product_path(@product)
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def book_name
  end
  end

  private

    def product_params
      params.require(:product).permit(:name, :kind, :cover_url, :price, :description)
    end
end
