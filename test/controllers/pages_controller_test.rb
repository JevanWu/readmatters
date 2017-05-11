require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @incomplete_user = create(:user)
    @user = create(:complete_user)
  end

  test "should get home" do
    get root_path
    assert_response :success
    sign_in @incomplete_user
    get root_path
    assert_redirected_to more_info_path
  end

  test "should get my_books" do
    get my_books_path
    assert_redirected_to new_user_session_path
    sign_in @user
    get my_books_path
    assert_response :success
  end

  test "should update more_info" do
    sign_in @user
    patch update_more_info_path, params: {
      user: {
        current_location: User.current_location.values.sample,
        phone: "18512341234"
      }
    }
    assert_redirected_to root_path
  end



end
