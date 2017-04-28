class Weibo
  def initialize
    # @agent = ::Mechanize.new { |agent|
    #   agent.user_agent_alias = 'Mac Safari'
    # }
    @agent = ::Mechanize.new
    @agent.cookie_jar.load_cookiestxt(Rails.root.join("cookie.txt").to_s)
    path = "http://weibo.com/u/5462436584/home?wvr=5"
    page = @agent.get(path)
    byebug
    # page.encoding = 'utf-8'
    File.open("test.html", 'w') do |file|
      file.puts page.body
    end

    # ookie = Mechanize::Cookie.new("ALIPAYJSESSIONID", "RZ13RFipKbQdhX6OAVqlnaa3haf4ZPauthGZ00RZ13")
    # cookie.domain = ".alipay.com"
    # cookie.path = "/"

    # email = '*********'#账号密码
    # password = '*********'
    #
    # agent = Mechanize.new
    # agent.user_agent_alias = 'Windows Mozilla'
    # page = agent.get('http://www.renren.com')
    # page.encoding = 'utf-8'
    #
    # # 填表登陆人人，登陆后的页面存放到login_page
    # form = page.forms.first
    # form.field_with(:name => 'email').value = email
    # form.field_with(:type => 'password').value = password
    # login_page = form.click_button
  end

  def agent
    @agent
  end
end
