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

  def move_current_location_to_province_and_city
    mapping = {
      'beijing' => '110000',
      'shanghai' => '310000',
      'guangzhou' => '',
      'shenzhen' => '',
      'hangzhou' => '',
      'chengdu' => ''
    }
  end
end
