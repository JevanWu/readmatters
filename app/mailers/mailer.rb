class Mailer < ActionMailer::Base
  default from: "robot@test.com"

  def welcome
    mail(to: "jevanwu@163.com", subject: 'Welcome to My Awesome Site')
  end
end
