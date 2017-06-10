class Mailer < ActionMailer::Base
  default from: "ReadMatters <no-reply@readmatters.com>"

  def welcome_email#(user)
    # @user = user
    @url  = 'http://example.com/login'
    # mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    mail(to: "84135180@qq.com", subject: 'Welcome to My Awesome Site')
  end

  #未读消息提醒
  def unread_message_notification(user, sender, message_content)
    @user = user
    @sender = sender
    @message_content = message_content
    @cta_url = chat_url
    mail(to: @user.email, subject: "#{@sender.name}一天前给您发送了一条消息，请及时查看")
  end

  #欢迎注册

  #支付成功
  def buyer_paid_success_notification(user, order)
    @user = user
    @order = order
    @book_names = order.book_names.map{|book| "《#{book}》"}.join("，")
    @cta_url = bought_orders_url
    mail(to: @user.email, subject: "支付成功！")
  end

  #等待发货
  def seller_order_ship_notification(user, order)
    @user = user
    @order = order
    @book_names = order.book_names.map{|book| "《#{book}》"}.join("，")
    @cta_url = sold_orders_url
    mail(to: @user.email, subject: "请及时发货并更新状态 ")
  end

  #等待买家确认
  def buyer_order_confirm_notification(user, order)
    @user = user
    @order = order
    @book_names = order.book_names.map{|book| "《#{book}》"}.join("，")
    @cta_url = bought_orders_url
    mail(to: @user.email, subject: "请及时查收并确认")
  end

  #订单交易成功（可能需要两封）
  def buyer_order_success_notification(user, order)
    @user = user
    @order = order
    @book_names = order.book_names.map{|book| "《#{book}》"}.join("，")
    @cta_url = root_url
    mail(to: @user.email, subject: "交易完成！感谢您")
  end

  def seller_order_success_notification(user, order)
    @user = user
    @order = order
    @book_names = order.book_names.map{|book| "《#{book}》"}.join("，")
    @cta_url = root_url
    mail(to: @user.email, subject: "交易完成！感谢您")
  end

  def new_user_report(emails, count)
    @emails = emails
    mail(to: 'jevan@readmatters.com', subject: "新注册用户#{count}个")
  end

  #等待退款
  # def order_wait_refund_notification(user)
  #   mail(to: user.email, subject: "")
  # end

  #已退款
  # def order_refunded_notification(user)
  #   mail(to: user.email, subject: "")
  # end
end
