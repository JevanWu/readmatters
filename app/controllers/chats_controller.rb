class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations
    @conversation = @conversations.first
    @comversation.mark_read
    # @friends = User.where(id: @conversations.pluck(:sender_id).uniq + @conversations.pluck(:recipient_id).uniq).where.not(id: current_user.id)
    # @orders = current_user.orders
    # order_ids = (@orders.pluck(:seller_id) + @orders.pluck(:user_id)).uniq
    # @friends = User.where(id: order_ids).where.not(id: current_user.id)
  end

end
