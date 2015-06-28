require 'nokogiri'
require 'open-uri'
require 'ostruct'

class ProductsController < ApplicationController

  def new
    redirect_to book_name_products_path if params[:book_id].nil?
    
    @product = Product.new
    _response = RestClient.get("https://api.douban.com/v2/book/#{params[:book_id]}", params: { fields: "title,image,summary,tags"})
    redirect_to book_name_products_path unless _response.code == 200
    response = JSON.parse _response
    @name = response["title"]
    @cover_url = response["image"]
    @description = response["summary"]
    @tags = response["tags"].map { |tag| tag["title"] }

    # doc = Nokogiri::HTML(open(params[:douban_link]).read)
    # if params[:douban_link].match /read.douban.com/
    #   @name = doc.css(".article-title").first.content
    #   @cover_url = doc.css(".cover img").first['src']
    #   @description = doc.css(".abstract-full .info p").map{|element| element.content}
    #                                                   .inject{|sum, element| sum + "/n" + element}
    #   @kind = "Instance"
    # elsif params[:douban_link].match /book.douban.com/
    #   @name = doc.css('h1 span').first.content
    #   @cover_url = doc.css('.nbg img').first['src']
    #   @description = doc.css('#link-report .intro').last.try(:content)
    #   @kind = doc.css('#db-tags-section .indent a').first.try(:content)
    # end
  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    @product = Product.find params[:id]
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
    end
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      # redirect_to product_path(@product)
      redirect_to upload_photo_product_path(@product)
    end
  end

  def upload_photo
    @product = Product.find params[:id]
  end

  def edit_photo
    @product = Product.find params[:id]
  end

  def create_photo
    product = Product.find params[:product_id]
    photo = product.photos.create(image: params[:product][:photo])
    respond_to do |format|
      format.json { render json: { id: photo.id, photo: photo.image.url }, status: :ok } 
    end
  end

  def photos
    @product = Product.find params[:id]
    @photos = @product.photos
  end

  def delete_photo
    photo = Photo.find params[:photo_id]
    respond_to do |format|
      if photo.delete
        format.json { render json: {}, status: :ok } 
      end
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
    _response = RestClient.get("https://api.douban.com/v2/book/search", params: { q: params[:book_name], fields: "title,url,id,image"})
    redirect_to book_name_products_path unless _response.code == 200
    response = JSON.parse _response
    count = response["count"]
    count.times do |num|
      book = OpenStruct.new
      book.cover = response["books"][num]["image"]
      book.href = response["books"][num]["url"]
      book.title = response["books"][num]["title"]
      book.id = response["books"][num]["id"]
      @books[num] = book
    end

    # self-grab from douban.com
    #
    # doc = Nokogiri::HTML(open(URI.escape("http://book.douban.com/subject_search?search_text=#{params[:book_name]}")).read)
    # items = doc.css(".subject-item")
    # items.each_with_index do |item, index|
    #   book = OpenStruct.new
    #   book.cover = item.css(".pic img").attribute("src").content.split("?")[0]
    #   book.href = item.css(".info a").attribute("href").content
    #   book.title = item.css(".info a").attribute("title").content
    #   @books[index] = book
    # end

    # #record the number of items have been counted
    # counted = items.count

    # doc = Nokogiri::HTML(open(URI.escape("http://read.douban.com/search?q=#{params[:book_name]}")).read)
    # items = doc.css(".item")
    # items.each_with_index do |item, index|
    #   book = OpenStruct.new
    #   book.cover = item.css(".cover img").attribute("src").content.split("?")[0]
    #   book.href = "http://read.douban.com" + item.css(".info .title a").attribute("href").content
    #   book.title = item.css(".info .title a").text
    #   @books[counted + index] = book
    # end
  end

  private

    def product_params
      params.require(:product).permit(:name, :kind, :cover_url, :price, :description)
    end
end
