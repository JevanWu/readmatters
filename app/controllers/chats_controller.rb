class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations
    if params[:chat_id].present?
      @conversation = @conversations.find(params[:chat_id])
    else
      @conversation = @conversations.first
    end
    current_user.mark_read(@conversation)
    # @friends = User.where(id: @conversations.pluck(:sender_id).uniq + @conversations.pluck(:recipient_id).uniq).where.not(id: current_user.id)
    # @orders = current_user.orders
    # order_ids = (@orders.pluck(:seller_id) + @orders.pluck(:user_id)).uniq
    # @friends = User.where(id: order_ids).where.not(id: current_user.id)
  end

end
