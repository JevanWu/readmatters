class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    sellers = @current_cart.products.map(&:user).uniq
    @line_item_grouped_hash = {}
    @total_prices = []
    sellers.each do |seller|
      line_items = @current_cart.line_items.eager_load(:product).where("products.user_id = ?", seller.id)
      @total_prices << Product.where(id: line_items.pluck(:product_id)).pluck(:price).inject(0, :+)
      @line_item_grouped_hash["#{seller.id},#{seller.name}"] = line_items
    end
  end
end
