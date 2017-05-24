class PagesController < ApplicationController
  before_action :check_infomation_completeness, except: [:more_info, :update_more_info]
  before_action :authenticate_user!, only: [:more_info, :my_books]

  def home
    @cart = current_cart
    if current_user.present?
      @products = Product.available.eager_load(:book).eager_load(:user).where.not(user_id: current_user.id, book_id: nil)
      @products.sort_by!{|product| product.user.current_location == current_user.current_location ? -1 : 1}
    else
      @products = Product.available.eager_load(:book).where.not(book_id: nil)
    end
    #@products = Product.available.eager_load(:book).eager_load(:user).where("users.current_location = ?", current_user.current_location).where.not(user_id: current_user.id)
  end

  def my_books
    @products = Product.available.eager_load(:book).where(user_id: current_user.id).where.not(book_id: nil)
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
      redirect_to :back, flash: { alert: combine_error_message(@user.errors.messages, "user") }
    end
  end

  private

  def more_info_params
    params.require(:user).permit(:name, :current_location, :phone)
  end
end
