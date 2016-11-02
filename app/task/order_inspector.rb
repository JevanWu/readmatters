class OrderInspector

  def self.inspect(key_id, amount)
    order = Order.find key_id
    if order.price == amount.to_f
      order.pay
    end
  end
end
