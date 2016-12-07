class UserMailerPreview < ActionMailer::Preview

  def welcome_email
    UserMailer.welcome_email#(User.first)
  end

  def confirmation_instructions
    UserMailer.confirmation_instructions(User.first, "faketoken", {})
  end
end
