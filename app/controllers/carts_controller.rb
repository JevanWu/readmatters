class CartsController < ApplicationController

  def show
    @cart = current_cart
    sellers = @cart.products.map(&:user)
    @line_item_grouped_hash = {}
    sellers.each do |seller|
      @line_item_grouped_hash["#{seller.id},#{seller.name}"] = @cart.line_items.eager_load(:product).where("products.user_id = ?", seller.id)
    end
  end
end
