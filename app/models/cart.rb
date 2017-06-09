class Cart < ApplicationRecord
  has_many :line_items
  has_many :products, through: :line_items
  belongs_to :user

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      # TODO: 提示已加入
      # current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id)
    end
    current_item
  end

  def remove_product(product)
    current_item = line_items.find_by(product_id: product.id)
    return if current_item.nil?
    current_item.delete
  end

  def clear
    self.line_items.destroy_all
  end

  def number_of_items
    self.line_items.count
    # quantity = 0
    # line_items.each do |item|
    #   quantity += item.quantity
    # end
    # quantity
  end

  def items_text
    items_text = ""
    line_items.each do |item|
      items_text << "<p> #{item.product.name} * #{item.quantity} </p>"
    end
    items_text
  end
end
