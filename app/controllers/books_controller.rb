class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
    else
      redirect_to :back, flash: { error: "failed" }
    end
  end

  private

    def book_params
      params.require(:book).permit(:name, :price, :author, :summary, :author_intro, :catalog, :published_date, :publisher)
    end
end
