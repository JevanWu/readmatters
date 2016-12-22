class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to new_product_path(new_book_id: @book.id)
    else
      redirect_to :back, flash: { alert: combine_error_message(@book.errors.messages, "book") }
    end
  end

  def update_cover
    @book = Book.find(params[:id])
  end

  private

    def book_params
      params.require(:book).permit(:name, :price, :author, :summary, :author_intro, :catalog, :published_date, :publisher, :cover)
    end
end
