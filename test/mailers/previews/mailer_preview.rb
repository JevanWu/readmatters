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
end
