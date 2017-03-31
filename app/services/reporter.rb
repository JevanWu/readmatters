class Reporter

  def new_user_report
    emails = User.where(created_at: Date.today.beginning_of_day..Date.today.end_of_day).pluck(:email)
    count = emails.count
    emails = emails.join(", ")
    Mailer.new_user_report(emails, count).deliver_later if count > 1
  end
end
