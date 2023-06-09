require "test_helper"

class WishListItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wish_list_item = wish_list_items(:one)
  end

  test "should get index" do
    get wish_list_items_url
    assert_response :success
  end

  test "should get new" do
    get new_wish_list_item_url
    assert_response :success
  end

  test "should create wish_list_item" do
    assert_difference("WishListItem.count") do
      post wish_list_items_url, params: { wish_list_item: {  } }
    end

    assert_redirected_to wish_list_item_url(WishListItem.last)
  end

  test "should show wish_list_item" do
    get wish_list_item_url(@wish_list_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_wish_list_item_url(@wish_list_item)
    assert_response :success
  end

  test "should update wish_list_item" do
    patch wish_list_item_url(@wish_list_item), params: { wish_list_item: {  } }
    assert_redirected_to wish_list_item_url(@wish_list_item)
  end

  test "should destroy wish_list_item" do
    assert_difference("WishListItem.count", -1) do
      delete wish_list_item_url(@wish_list_item)
    end

    assert_redirected_to wish_list_items_url
  end
end
