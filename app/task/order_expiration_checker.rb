class OrderExpirationChecker
  include Sidekiq::Worker
  def perform(id)
    order = Order.find id
    order.failure if order.wait_pay? && order.expired?
  end
end
