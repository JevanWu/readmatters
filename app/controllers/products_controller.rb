require 'nokogiri'
require 'open-uri'
require 'ostruct'

class ProductsController < ApplicationController

  def book_links
    redirect_to book_name_products_path if params[:book_name].nil?
    _response = RestClient.get("https://api.douban.com/v2/book/search", params: { q: params[:book_name]}) # , fields: "title,url,id,image"
    redirect_to book_name_products_path unless _response.code == 200
    response = JSON.parse _response
    book_count = Redis::Value.new("book_count_#{current_user.id}") 
    book_count.value = response["count"]
    @book_list = Redis::List.new("book_list_#{current_user.id}", :marshal => true)
    @book_list.push(*response["books"])
  end

  def new
    redirect_to book_name_products_path if params[:book_id].nil?
    
    @product = Product.new
    @book_list = Redis::List.new("book_list_#{current_user.id}", :marshal => true)
    book = @book_list[params[:book_id]]
    @book_id = params[:book_id]
    @name = book["title"]
    @cover_url = book["image"]
    @summary = book["summary"]
    @tags = book["tags"].map { |tag| tag["name"] }
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
    @book_list = Redis::List.new("book_list_#{current_user.id}", :marshal => true)
    book = @book_list[params[:product][:book_id]]
    extra_params = {
      isbn: book["isbn13"] || book["isbn10"],
      original_cover: book["image"],
      author: book["author"],
      author_intro: book["author_intro"],
      catalog: book["catalog"],
      publisher: book["publisher"],
      published_date: book["pubDate"].to_date,
      data: book
    }
    @product = Product.new(product_params.merge(extra_params))
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

  private

    def product_params
      params.require(:product).permit(:name, :tags, :cover_url, :price, :summary)
    end
end
