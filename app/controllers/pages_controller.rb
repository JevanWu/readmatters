class PagesController < ApplicationController
  before_action :check_infomation_completeness, except: [:more_info, :update_more_info]
  before_action :authenticate_user!, only: [:more_info, :fetch_more_books]

  def home
    if params[:finish_survey]
      flash[:notice] = "非常感谢填写问卷！你可以继续浏览书籍"
    end
    @cart = current_cart
    if current_user.present?
      @products = Product.select("case users.current_location when '#{current_user.current_location}' then 1 else 2 end as user_location").available.eager_load(:book).eager_load(:user).where.not(user_id: current_user.id, book_id: nil).order("user_location desc").take(20)
      # @products = @products.sort_by{|product| product.user.current_location == current_user.current_location ? -1 : 1}
    else
      @products = Product.available.eager_load(:book).where.not(book_id: nil)
    end
    #@products = Product.available.eager_load(:book).eager_load(:user).where("users.current_location = ?", current_user.current_location).where.not(user_id: current_user.id)
  end

  def fetch_more_books
    skip_num = params[:skip] || 20
    products = Product.select("case users.current_location when '#{current_user.current_location}' then 1 else 2 end as user_location").available.eager_load(:book).eager_load(:user).where.not(user_id: current_user.id, book_id: nil).order("user_location desc").offset(skip_num).take(10)
    more_books_html = ""
    products.each do |product|
      more_books_html << render_to_string(partial: 'product_partial', locals: { product: product })
    end
    render json: { html: more_books_html }, satuts: :ok
  end

  def personal_books
    @user = User.find_by(personal_link: params[:personal_link])
    @products = Product.available.eager_load(:book).where(user_id: @user.id).where.not(book_id: nil)
    render "home"
  end

  def search
    keyword = params[:keyword]
    @products = Product.available.eager_load(:book).where("lower(books.name) LIKE :keyword or lower(books.author) LIKE :keyword", keyword: "%#{keyword.downcase}%")
    @title = "关键字：#{keyword}"
    render "home"
  end

  def owner
    user = User.find(params[:id])
    @products = user.products.available.eager_load(:book).where.not(book_id: nil)
    @title = "#{user.name}的书籍"
    render "home"
  end

  def more_info
    @user = current_user
  end

  def update_more_info
    @user = current_user
    @user.assign_attributes(more_info_params)
    if @user.save(context: :more_info)
      redirect_to root_path
    else
      redirect_back(fallback_location: root_url, flash: { alert: combine_error_message(@user.errors.messages, "user") })
    end
  end

  private

  def more_info_params
    params.require(:user).permit(:name, :current_location, :phone)
  end
end
