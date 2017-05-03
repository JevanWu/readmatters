class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.fetch(current_user.id)
  end

end
