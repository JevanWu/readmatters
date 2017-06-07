module BooksHelper

  def price_hint(product)
    hint = "（建议转售价格为购入价格的3到6折）"
    if product.book_price.to_i > 0
      hint = "（该书参考价为#{ number_to_currency(product.book_price, unit: "¥") }, 建议转售价格为购入价格的3到6折，即#{ number_to_currency(product.book_price*0.3, unit: "¥") }~#{ number_to_currency(product.book_price*0.6, unit: "¥") }）"
    end
    hint
  end
end
