class WashData

  def self.complement_rating_data
    books = Book.all
    books.each do |book|
      book_info = book.raw_data
      book.rating = book_info["rating"]["average"]
      book.num_of_raters = book_info["rating"]["numRaters"]
      book.hq_cover = book_info["images"]["large"]
      book.save
    end
  end

  def self.move_current_location_to_province_and_city
    User.where(current_location: "beijing").update_all(province: '110000', city: '110100', district: '110101')
    User.where(current_location: "shanghai").update_all(province: '310000', city: '310100', district: '310115')
    User.where(current_location: "guangzhou").update_all(province: '440000', city: '440100', district: '440101')
    User.where(current_location: "shenzhen").update_all(province: '440000', city: '440300', district: '440301')
    User.where(current_location: "hangzhou").update_all(province: '330000', city: '330100', district: '330101')
    User.where(current_location: "chengdu").update_all(province: '510000', city: '510100', district: '510101')
  end
end
