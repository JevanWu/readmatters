#!/usr/bin/env ruby
require 'rubygems'
require 'rest_client'

class MailRobot

  def self.send_mail
    response = RestClient.post "http://sendcloud.sohu.com/webapi/mail.send.json",
    :api_user => "84135180_test_XDMAdy",
    :api_key => "vhn0xu2rmEr2EMMJ",
    :from => "service@sendcloud.im",
    :fromname => "SendCloud测试邮件",
    :to => "84135180@qq.com",
    :subject => "来自SendCloud的第一封邮件！",
    :html => "你太棒了！你已成功的从SendCloud发送了一封测试邮件，接下来快登录前台去完善账户信息吧！",
    :resp_email_id => "true"
    return response
  end

end
