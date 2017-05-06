class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.fetch(current_user.id)
    @friends = User.where(id: @conversations.pluck(:sender_id).uniq + @conversations.pluck(:recipient_id).uniq).where.not(id: current_user.id)
    @conversation = Conversation.between(current_user, @friends.first).take
    # @orders = current_user.orders
    # order_ids = (@orders.pluck(:seller_id) + @orders.pluck(:user_id)).uniq
    # @friends = User.where(id: order_ids).where.not(id: current_user.id)
  end

end
