namespace :notification do

  desc "unread messages notification"
  task send_unread_messages_notification: :environment do
    Message.unread.where(created_at: 2.days.ago..1.days.ago).each do |message|
      sender = message.user
      recipient = message.conversation.opposed_user(sender)
      Mailer.unread_message_notification(recipient, sender, message.body).deliver_later
    end
  end
end
