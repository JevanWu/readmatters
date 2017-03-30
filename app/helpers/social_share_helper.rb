module SocialShareHelper
  def social_share_title(book_name)
    "我正在Readmatters转售书籍《#{book_name}》"
  end

  def social_share_summary
  end

  def social_share_source
    "http://readmatters.com"
  end

  def social_share_summary(book_name, book_summary)
    "我正在Readmatters转售书籍《#{book_name}》，快来看看吧。#{book_summary}"
  end
end
