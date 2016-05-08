class UserMailer < ActionMailer::Base
  default from: "84135180@qq.com"

  def welcome_email#(user)
    # @user = user
    @url  = 'http://example.com/login'
    # mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    mail(to: "84135180@qq.com", subject: 'Welcome to My Awesome Site')
  end
end
