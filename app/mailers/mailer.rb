class Mailer < ActionMailer::Base
  default from: "84135180@qq.com"

  def welcome_email#(user)
    # @user = user
    @url  = 'http://example.com/login'
    # mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    mail(to: "84135180@qq.com", subject: 'Welcome to My Awesome Site')
  end

  #验证邮箱
  def confirm_email(user)
    mail(to: user.email, subject: "")
  end

  #欢迎注册

  #等待发货
  def order_wait_ship_notification(user)
    mail(to: user.email, subject: "")
  end

  #等待买家确认
  def order_wait_confirm_notification(user)
    mail(to: user.email, subject: "")
  end

  #订单交易成功（可能需要两封）
  def order_success_notification(user)
    mail(to: user.email, subject: "")
  end

  #等待退款
  def order_wait_refund_notification(user)
    mail(to: user.email, subject: "")
  end

  #已退款
  def order_refunded_notification(user)
    mail(to: user.email, subject: "")
  end
end
