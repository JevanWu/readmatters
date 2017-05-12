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

  def self.fetch_or_create(sender_id, recipient_id)
    conversation = between(sender_id, recipient_id).first
    return conversation if conversation.present?

    create(sender_id: sender_id, recipient_id: recipient_id)
  end

  def opposed_user(user)
    user == recipient ? sender : recipient
  end

  def unread_count(user)
    self.messages.where(read_at: nil).where.not(user_id: user.id).count
  end

  def send_message(user, message)
    self.messages.create(user: user, body: message)
  end
end
