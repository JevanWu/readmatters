require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:complete_user)
    @product = create(:product)
  end

  test "should add a product to cart" do
    sign_in @user
    assert_difference('LineItem.count') do
      post line_items_path, params: { product_id: @product.id }
    end
  end

  test "should delete a product from cart" do
    sign_in @user
    assert_difference('LineItem.count', -1) do
      delete line_item_path(id: @product.id)
    end
  end
end
