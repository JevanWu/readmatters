class ProductsController < ApplicationController

  def book_links
    begin
      redirect_to book_name_products_path if params[:book_name].nil?
      _response = RestClient.get("https://api.douban.com/v2/book/search", params: { q: params[:book_name]}) # , fields: "title,url,id,image"
      redirect_to book_name_products_path unless _response.code == 200
      response = JSON.parse _response
      book_count = Redis::Value.new("book_count_#{current_user.id}")
      @book_list = Redis::List.new("book_list_#{current_user.id}", :marshal => true)
      book_count.clear
      @book_list.clear
      book_count.value = response["count"]
      @book_list.push(*response["books"])
    rescue
      # 从数据库查询结果
      if books = Book.where(name: params[:book_name]) && books.present?
        @book_list = Redis::List.new("book_list_#{current_user.id}", :marshal => true)
        books.each do |book|
          @book_list << {:image => book.cover_url, :title => book.name, :summary => book.summary,
                         :tags => book.tags, :author_intro => book.author_intro, :catalog => book.catalog }
        end
      else
        redirect_to new_product_path, flash: { notice: controller_translate("fetch_occur_error") }
      end
    end
  end

  def new
    @product = Product.new
    if params[:book_id].blank?
      @tags = []
    else
      @book_list = Redis::List.new("book_list_#{current_user.id}", :marshal => true)
      new_book = @book_list[params[:book_id]]
      isbn = new_book["isbn13"] || new_book["isbn10"]
      book = Book.find_by(isbn: isbn)
      if book.blank?
        tags = new_book["tags"].map{ |tag| tag["name"] }.join(", ")
        book = Book.create( isbn: isbn, name: new_book["title"], tags: tags, cover_url: new_book["image"],
                            price: new_book["price"], summary: new_book["summary"], author: new_book["author"].join(", "),
                            author_intro: new_book["author_intro"], catalog: new_book["catalog"], original_cover: new_book["image"],
                            publisher: new_book["publisher"], published_date: new_book["published_date"], raw_data: new_book)
      end
      @product.book_id = book.id
      @book_id = params[:book_id]
    end
  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    @product = Product.find params[:id]
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
    end
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      # redirect_to product_path(@product)
      redirect_to upload_photo_product_path(@product)
    else
      redirect_to :back, flash: { error: "failed" }
    end
  end

  def upload_photo
    @product = Product.find params[:id]
  end

  def edit_photo
    @product = Product.find params[:id]
  end

  def create_photo
    product = Product.find params[:product_id]
    photo = product.photos.create(image: params[:product][:photo])
    respond_to do |format|
      format.json { render json: { id: photo.id, photo: photo.image.url }, status: :ok }
    end
  end

  def photos
    @product = Product.find params[:id]
    @photos = @product.photos
  end

  def delete_photo
    photo = Photo.find params[:photo_id]
    respond_to do |format|
      if photo.delete
        format.json { render json: {}, status: :ok }
      end
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def book_name
  end

  private

    def product_params
      params.require(:product).permit(:tags, :cover_url, :price, :summary, :book_id)
    end

    def book_extra_params
      extra_params = {
        isbn: @book["isbn13"] || book["isbn10"],
        original_cover: @book["image"],
        author: @book["author"].join(", "),
        publisher: @book["publisher"],
        published_date: @book["pubdate"].count("-") == 1 ? "#{@book["pubdate"]}-01".to_date : @book["pubdate"].to_date,
        raw_data: @book
      }
    end
end
