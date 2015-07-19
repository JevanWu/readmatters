module ProductsHelper

  def bought_order_trigger(order)
    case order.state
    when %(wait_pay)
      link_to "去付款", checkout_path(order)
    when %(wait_ship)
      "卖者在准备发货"
    when %(wait_confirm)
      link_to "确认收货", "#"
    when %(wait_refund)
      "退款已经在处理中"
    end
  end
end
