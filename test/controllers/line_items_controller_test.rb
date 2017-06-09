require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:complete_user)
    @seller = create(:seller)
    @product = create(:product, user: @seller)
  end

  test "should add a product to cart" do
    sign_in @user
    assert_difference('LineItem.count') do
      post line_items_path, params: { product_id: @product.id }
    end
  end

  test "should delete a product from cart" do
    sign_in @user
    line_item = @user.cart.add_product(@product)
    line_item.save
    assert_difference('LineItem.count', -1) do
      delete line_item_path(id: @product.id)
    end
  end
end
