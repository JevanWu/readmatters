class Cart < ActiveRecord::Base
  has_many :line_items

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id)
    end
    current_item
  end

  def number_of_items
    quantity = 0
    line_items.each do |item|
      quantity += item.quantity
    end
    quantity
  end

  def items_text
    items_text = ""
    line_items.each do |item|
      items_text << "<p> #{item.product.name} * #{item.quantity} </p>"
    end
    items_text
  end
end
