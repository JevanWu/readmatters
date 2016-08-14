module ProductsHelper

  def bought_order_triggers(order)
    case order.state
    when %(wait_pay)
      link_to "去付款", checkout_path(order)
    when %(wait_ship)
      "卖家正在发货..."
    when %(wait_confirm)
      link_to "确认收货", confirm_order_path(order.identifier), remote: true, method: :post
    when %(wait_refund)
      "退款已在处理中"
    end
  end

  def sold_order_triggers(order)
    case order.state
    when %(wait_pay)
      "买家还未付款"
    when %(wait_ship)
      link_to "我已经发货", ship_order_path(order.identifier), remote: true, method: :post
    when %(wait_confirm)
      "等待买家确认"
    when %(wait_refund)
      "买家已申请退款"
    end
  end

  def order_triggers(order)
    if order.buyer == current_user
      bought_order_triggers(order)
    elsif order.seller == current_user
      sold_order_triggers(order)
    end
  end

  def order_inscribe(order)
    if order.buyer == current_user
      "From: #{order.seller.name}"
    elsif order.seller == current_user
      "To: #{order.receiver_name}"
    end
  end
end
