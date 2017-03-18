module BooksHelper

  def price_hint(product)
    hint = "（建议填写新书3到6折的转售价格）"
    if product.book_price.to_i > 0
      hint = "《#{product.book.name}》新书参考价为#{ number_to_currency(product.book_price, unit: "¥") }, 建议填写新书3到6折的转售价格，即#{ number_to_currency(product.book_price*0.3, unit: "¥") }～#{ number_to_currency(product.book_price*0.6, unit: "¥") }"
    end
    hint
  end
end
