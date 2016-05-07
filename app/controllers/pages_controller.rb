class PagesController < ApplicationController

  def home
    @cart = current_cart
    @products = Product.all
  end

  def search
    @products = Product.where("name LIKE ?", "%#{params[:key_word][:book_name]}%")
    render "home"
  end
  
end
