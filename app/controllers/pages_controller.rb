class PagesController < ApplicationController

  def home
    @cart = current_cart
    @products = Product.available
  end

  def search
    @products = Product.eager_load(:book).where("books.name LIKE ?", "%#{params[:key_word][:book_name]}%")
    render "home"
  end
end
