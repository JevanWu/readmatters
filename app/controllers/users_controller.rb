class UsersController < ApplicationController

  # def timeline
  #   @partial = "timeline"
  #   respond_to do |format|
  #     format.html
  #     format.js { render "update_partial", layout: false }
  #   end
  # end

  def bought_books
    @partial = "bought_books"
    respond_to do |format|
      format.html
      format.js { render "update_partial", layout: false }
    end
  end

  def selling_books
    @partial = "selling_books"
    respond_to do |format|
      format.html
      format.js { render "update_partial", layout: false }
    end
  end

  def sold_books
    @partial = "sold_books"
    respond_to do |format|
      format.html
      format.js { render "update_partial", layout: false }
    end
  end

  def setting
    @partial = "setting"
    @user = current_user
    respond_to do |format|
      format.html
      format.js { render "update_partial", layout: false }
    end
  end

  def update_info
    current_user.update(user_params)
    redirect_to user_setting_path
  end

  def update_avatar
    current_user.update_attribute(:avatar, params[:user][:avatar])
    respond_to do |format|
      format.json { render json: {image: current_user.avatar.url}, status: :ok }
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :phone)
    end
end
