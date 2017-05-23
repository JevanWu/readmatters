class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  scope :order_by_time, -> { order("created_at asc") }
  scope :unread, -> { where(read_at: nil) }
end
