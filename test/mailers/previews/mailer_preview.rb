class MailerPreview < ActionMailer::Preview

  # http://localhost:3000/rails/mailers/mailer/buyer_paid_success_notification
  def buyer_paid_success_notification
    user = User.first
    order = Order.first
    Mailer.buyer_paid_success_notification(user, order)
  end

  def seller_order_ship_notification
    user = User.first
    order = Order.first
    Mailer.seller_order_ship_notification(user, order)
  end

  def buyer_order_confirm_notification
    user = User.first
    order = Order.first
    Mailer.buyer_order_confirm_notification(user, order)
  end

  def buyer_order_success_notification
    user = User.first
    order = Order.first
    Mailer.buyer_order_success_notification(user, order)
  end

  def seller_order_success_notification
    user = User.first
    order = Order.first
    Mailer.seller_order_success_notification(user, order)
  end

  def unread_message_notification
    user = User.first
    message_content = "你好啊"
    sender = User.last
    Mailer. unread_message_notification(user, sender, message_content)
  end
end
