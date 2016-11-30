class OrderExpirationChecker
  include Sidekiq::Worker
  def perform(id)
    order = Order.find id
    order.unlock_products if order.wait_pay? && order.expired?
  end
end
