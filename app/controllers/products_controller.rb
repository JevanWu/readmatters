require 'nokogiri'
require 'open-uri'
require 'ostruct'

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
      @description = doc.css('#link-report .intro').last.try(:content)
      @kind = doc.css('#db-tags-section .indent a').first.try(:content)
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

  def book_links
    redirect_to book_name_products_path if params[:book_name].nil?
    @books = []
    doc = Nokogiri::HTML(open(URI.escape("http://book.douban.com/subject_search?search_text=#{params[:book_name]}")).read)
    items = doc.css(".subject-item")
    items.each_with_index do |item, index|
      book = OpenStruct.new
      book.cover = item.css(".pic img").attribute("src").content
      book.href = item.css(".info a").attribute("href").content
      book.title = item.css(".info a").attribute("title").content
      @books[index] = book
    end

    #record the number of items have been counted
    counted = items.count

    doc = Nokogiri::HTML(open(URI.escape("http://read.douban.com/search?q=#{params[:book_name]}")).read)
    items = doc.css(".item")
    items.each_with_index do |item, index|
      book = OpenStruct.new
      book.cover = item.css(".cover img").attribute("src").content
      book.href = "http://read.douban.com" + item.css(".info .title a").attribute("href").content
      book.title = item.css(".info .title a").text
      @books[counted + index] = book
    end
  end

  private

    def product_params
      params.require(:product).permit(:name, :kind, :cover_url, :price, :description)
    end
end
