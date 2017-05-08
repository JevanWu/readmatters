class MessagesController < ApplicationController
  def create
    @conversation = Conversation.includes(:recipient).find(params[:conversation_id])
    @message = @conversation.messages.create(message_params)

    message_html = render_to_string(partial: 'messages/message', locals: { message: @message, user: current_user })

    respond_to do |format|
      format.json { render json: { message_html: message_html }, status: :ok }
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :body)
  end
end
