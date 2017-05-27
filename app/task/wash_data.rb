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
end
