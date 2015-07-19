module ProductsHelper

  def bought_order_triggers(order)
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

  def sold_order_triggers(order)
    case order.state
    when %(wait_pay)
      "买者还未付款"
    when %(wait_ship)
      link_to "已经发货", "#"
    when %(wait_confirm)
      "等待买者收货"
    when %(wait_refund)
      "买者已经申请退款"
    end
  end
end
