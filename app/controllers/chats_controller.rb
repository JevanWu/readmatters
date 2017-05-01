class ChatsController < ApplicationController

  def index
    @conversations = current_user.conversations
  end

end
