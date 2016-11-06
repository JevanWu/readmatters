class OrderInspector

  def self.inspect(pay_code, amount)
    order = Order.find_by(pay_code: pay_code)
    if order.price == amount.to_f
      order.pay
      order.update(pay_code: nil)
    end
  end
end
