class Conversation < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  belongs_to :sender, foreign_key: :sender_id, class_name: User
  belongs_to :recipient, foreign_key: :recipient_id, class_name: User

  validates :sender_id, uniqueness: { scope: :recipient_id }

  scope :fetch, -> (user_id) { where("sender_id = ? or recipient_id = ?", user_id, user_id)}
  scope :between, -> (sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id)
    )
  end

  def self.get(sender_id, recipient_id)
    conversation = between(sender_id, recipient_id).first
    return conversation if conversation.present?

    create(sender_id: sender_id, recipient_id: recipient_id)
  end

  def opposed_user(user)
    user == recipient ? sender : recipient
  end

  def send_message(user, message)
    self.messages.create(user: user, body: message)
  end

  def send_order_info(order)
    message = "订单号#{order.identifier}:\n"
    message << "<div>"
    order.books.each do |book|
      message << "<img src=#{book.cover.url}></img>"
    end
    message << "</div>\n"
    message << "价格为: ¥#{order.total_price}"

    send_message(order.buyer, message)
  end
end
