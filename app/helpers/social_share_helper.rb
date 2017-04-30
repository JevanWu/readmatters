module SocialShareHelper
  def social_share_title(product)
    book_name = product.name
    if current_user == product.owner
      "我正在readmatters.com转售书籍《#{book_name}》"
    else
      "我正在readmatters.com购买书籍《#{book_name}》"
    end
  end

  def social_share_source
    "http://readmatters.com"
  end

  def social_share_summary(product)
    book_name = product.name
    book_summary = product.book_summary
    if current_user == product.owner
      "我正在readmatters.com转售书籍《#{book_name}》，快来看看吧。#{book_summary}"
    else
      "我正在readmatters.com购买书籍《#{book_name}》，快来看看吧。#{book_summary}"
    end
  end
end
