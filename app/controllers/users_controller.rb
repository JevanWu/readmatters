class UsersController < ApplicationController

  def timeline 
    @partial = "timeline"
    respond_to do |format|
      format.html
      format.js { render "update_partial", layout: false }
    end
  end

  def bought_books
    @partial = "bought_books"
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
end
