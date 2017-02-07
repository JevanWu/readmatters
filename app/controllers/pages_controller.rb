class PagesController < ApplicationController

  def home
    @cart = current_cart
    @products = Product.available.eager_load(:book)
  end

  def search
    book_name = params[:key_word][:book_name]
    @products = Product.eager_load(:book).where("lower(books.name) LIKE ?", "%#{book_name.downcase}%")
    @title = "关键字：#{book_name}"
    render "home"
  end

  def owner
    user = User.find(params[:id])
    @products = user.products.eager_load(:book)
    @title = "#{user.name}的书籍"
    render "home"
  end
end
