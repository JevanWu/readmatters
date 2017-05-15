require 'test_helper'

class PublishBookTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:complete_user)
  end

  test "can publish book" do
    sign_in @user

    get book_name_products_path
    assert_select ".hint", I18n.t("products.book_name.title")

    get book_links_products_path, params: {book_name: "创业维艰"}
    assert_select ".title", "创业维艰"

    get new_book_path, params: {book_id: 1}
    assert_response :success
  end

end
