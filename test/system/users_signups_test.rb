require "application_system_test_case"

class UsersSignupsTest < ApplicationSystemTestCase
  test "signup" do
    visit new_user_registration
    fill_in "user_email", with: "rm_test@gmail.com"
    fill_in "user_password", with: "11111111"
    click_on "注册"

    assert_text I18n.t("devise.registrations.signed_up_but_unconfirmed")
  end
  # test "visiting the index" do
  #   visit users_signups_url
  #
  #   assert_selector "h1", text: "UsersSignup"
  # end
end
