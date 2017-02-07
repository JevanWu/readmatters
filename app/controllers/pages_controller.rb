class PagesController < ApplicationController

  def home
    @cart = current_cart
    @products = Product.available.eager_load(:book)
  end

  def search
    @products = Product.eager_load(:book).where("lower(books.name) LIKE ?", "%#{params[:key_word][:book_name].downcase}%")
    render "home"
  end

  def owner
    user = User.find(params[:id])
    @products = user.products.eager_load(:book)
    render "home"
  end
end
