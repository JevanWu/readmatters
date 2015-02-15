class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  belongs_to :province
  belongs_to :city
  belongs_to :district

  def add_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
