class PagesController < ApplicationController

  def home
    @cart = current_cart
    @products = Product.all
  end
  
end
