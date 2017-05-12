class ConversationsController < ApplicationController
  # def create
  #   @conversation = Conversation.get(current_user.id, params[:user_id])
  #
  #   add_to_conversations unless conversated?
  #
  #   respond_to do |format|
  #     format.js
  #   end
  # end

  def fetch
    friend_id = params[:friend_id]
    return if friend_id.blank?
    conversation = Conversation.between(current_user.id, friend_id).take
    conversation.mark_read
    conversation_html = render_to_string(partial: 'conversations/conversation', locals: { conversation: conversation, user: current_user })
    respond_to do |format|
      format.json { render json: { conversation_html: conversation_html }, status: :ok }
    end
  end

  private

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end
end
