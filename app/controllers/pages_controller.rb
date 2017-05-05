class PagesController < ApplicationController
  before_action :check_infomation_completeness, except: [:more_info, :update_more_info]
  before_action :authenticate_user!, only: [:more_info]

  def home
    @cart = current_cart
    if current_user.present?
      @products = Product.available.eager_load(:book).eager_load(:user).where.not(user_id: current_user.id, book_id: nil)
    else
      @products = Product.available.eager_load(:book).where.not(book_id: nil)
    end
    #@products = Product.available.eager_load(:book).eager_load(:user).where("users.current_location = ?", current_user.current_location).where.not(user_id: current_user.id)
  end

  def my_books
    @products = Product.available.eager_load(:book).where(user_id: current_user.id)
    render "home"
  end

  def search
    book_name = params[:key_word][:book_name]
    @products = Product.available.eager_load(:book).where("lower(books.name) LIKE ?", "%#{book_name.downcase}%")
    @title = "关键字：#{book_name}"
    render "home"
  end

  def owner
    user = User.find(params[:id])
    @products = user.products.available.eager_load(:book)
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
