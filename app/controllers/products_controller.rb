class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :check_infomation_completeness, only: [:show]
  before_action :set_product, except: [:book_links, :new, :create, :show]
  before_action :authenticate_owner, only: [:edit, :withdraw]

  def book_links
    begin
      return redirect_to book_name_products_path if params[:book_name].nil?
      _response = RestClient.get("https://api.douban.com/v2/book/search", params: { q: params[:book_name]}) # , fields: "title,url,id,image"
      return redirect_to book_name_products_path unless _response.code == 200
      response = JSON.parse _response
      return redirect_to book_name_products_path, flash: { alert: "搜索不到该书籍，请换其他关键词重试" } if response["count"] == 0
      book_count = Redis::Value.new("book_count_#{current_user.id}")
      @book_list = Redis::List.new("book_list_#{current_user.id}", :marshal => true)
      book_count.clear
      @book_list.clear
      book_count.value = response["count"]
      @book_list.push(*response["books"])
    rescue => e
      # 从数据库查询结果
      if books = Book.where(name: params[:book_name])
        @book_list = Redis::List.new("book_list_#{current_user.id}", :marshal => true)
        books.each do |book|
          @book_list << {:image => book.original_cover, :title => book.name, :summary => book.summary,
                         :tags => book.tags, :author_intro => book.author_intro, :catalog => book.catalog }
        end
      else
        redirect_back(fallback_location: book_name_products_url, flash: { alert: "搜索不到该书籍，请联系我们解决" })
        # redirect_to new_product_path, flash: { notice: controller_translate("fetch_occur_error") }
      end
    end
  end

  def new
    # 新建图书
    if params[:new_book_id].blank?
      @product = Product.new
    else
      @book = Book.find params[:new_book_id]
      @product = @book.products.build(price: @book.price, summary: @book.summary)
    end

    # 新建产品
    if params[:book_id].blank?
      @tags = []
    else
      @book_list = Redis::List.new("book_list_#{current_user.id}", :marshal => true)
      new_book = @book_list[params[:book_id]]
      isbn = new_book["isbn13"] || new_book["isbn10"]
      @book = Book.find_or_initialize_by(isbn: isbn)
      tags = new_book["tags"].map{ |tag| tag["name"] }.join(", ")
      @book.update(
                    isbn: isbn,
                    name: new_book["title"],
                    tags: tags,
                    price: new_book["price"],
                    summary: new_book["summary"],
                    author: new_book["author"].join(", "),
                    author_intro: new_book["author_intro"],
                    catalog: new_book["catalog"],
                    original_cover: new_book["image"],
                    hq_cover: new_book["images"]["large"],
                    publisher: new_book["publisher"],
                    published_date: new_book["published_date"],
                    rating: new_book["rating"]["average"],
                    num_of_raters: new_book["rating"]["numRaters"],
                    raw_data: new_book,
                    # 暂时不自己保存图片了
                    # cover_url: new_book["image"],
                  )
      @product.book_id = @book.id
      @book_id = params[:book_id]
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
    end
  end

  def create
    @product = Product.new(product_params)
    if duplicated?(@product)
      return redirect_back(fallback_location: root_url, flash: { alert: "您已经发布过该书籍" })
    end
    @product.user = current_user

    @product.valid?

    book = @product.book
    if book.present?
      if params[:category_list].present?
        book.category_list.add(params[:category_list], parse: true)
        book.save
      else
        @product.errors.add(:category_list, :blank)
      end
    end

    error_messages = @product.errors.messages

    if error_messages.blank?
      @product.save
      # redirect_to product_path(@product)
      redirect_to upload_photo_product_path(@product)
    else
      redirect_back(fallback_location: new_product_url, flash: { alert: combine_error_message(error_messages, "product") })
    end
  end

  def upload_photo
  end

  def edit_photo
  end

  def create_photo
    product = Product.find params[:product_id]
    photo = product.photos.create(image: params[:product][:photo])
    respond_to do |format|
      format.json { render json: { id: photo.id, photo: photo.image.url }, status: :ok }
    end
  end

  def photos
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
    if params[:published]
      flash[:notice] = "恭喜您发布书籍成功！您可以通过分享您的该书籍让更多人知道"
    end
    @product = Product.where(id: params[:id]).includes(:book, :photos, :user).take

    #TODO change the page which notify user the product is not available or sold out
    raise ActiveRecord::RecordNotFound if @product.blank?
  end

  def book_name
  end

  def withdraw
    @product.update(status: "withdrawn")
    redirect_to personal_books_path(current_user), flash: { notice: "《#{@product.name}》下架成功" }
  end

  def prefetch_category_tags
    ret = []
    prefetch_tags.each do |tag|
      ret << { "tag": tag }
    end
    render json: ret, status: :ok
  end

  def fetch_category_tags
    keyword = params[:keyword]
    tags = ActsAsTaggableOn::Tag.where("name like ?", "%#{keyword}%")
    ret = []
    tags.each do |tag|
      ret << { "tag": tag.name }
    end
    render json: ret, status: :ok
  end

  private

    def duplicated?(product)
      book_ids = current_user.products.pluck(:book_id).uniq
      book_ids.include?(product.book_id)
    end

    def authenticate_owner
      redirect_back(fallback_location: root_url, flash: { alert: "不好意思，您没有该操作的权利" }) if @product.owner != current_user
    end

    def set_product
      @product = Product.find(params[:id]) if params[:id].present?
    end

    def product_params
      params.require(:product).permit(:tags, :price, :summary, :book_id)
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

    def prefetch_tags
      %w(文学 小说 传记 经济管理 投资理财 历史 哲学与宗教 心理学 健身与保健 考试 英语 计算机 艺术与摄影 教材 互联网 程序员)
    end
end
