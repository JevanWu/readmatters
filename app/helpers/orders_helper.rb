module OrdersHelper

  def bought_order_triggers(order)
    case order.state
    when %(wait_pay)
      link_to "去付款", checkout_path(order), class: "btn btn-theme"
    when %(wait_ship)
      "卖家正在发货..."
    when %(wait_confirm)
      link_to "确认已收货", confirm_order_path(order.identifier), method: :post, class: "btn btn-theme"
    when %(wait_refund)
      "退款已在处理中"
    when %(failure)
      "已失效"
    when %(success)
      "已完成交易"
    when %(refunded)
      "已退款"
    when %(free)
      # link_to "委托交易并付款", checkout_path(order), class: "btn btn-theme"
    end
  end

  def sold_order_triggers(order)
    case order.state
    when %(wait_pay)
      "买家还未付款"
    when %(wait_ship)
      link_to "标记为已发货", ship_order_path(order.identifier), method: :post, class: "btn btn-theme"
    when %(wait_confirm)
      "等待买家确认"
    # when %(wait_refund)
    #   link_to "已退款", "#"
      #"买家已申请退款"
    when %(failure)
      "已失效"
    when %(success)
      "已完成交易"
    when %(refunded)
      "已退款"
    when %(free)
      "买方稍后会联系您"
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
