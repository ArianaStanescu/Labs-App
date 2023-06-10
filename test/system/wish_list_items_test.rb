require "application_system_test_case"

class WishListItemsTest < ApplicationSystemTestCase
  setup do
    @wish_list_item = wish_list_items(:one)
  end

  test "visiting the index" do
    visit wish_list_items_url
    assert_selector "h1", text: "Wish list items"
  end

  test "should create wish list item" do
    visit wish_list_items_url
    click_on "New wish list item"

    click_on "Create Wish list item"

    assert_text "Wish list item was successfully created"
    click_on "Back"
  end

  test "should update Wish list item" do
    visit wish_list_item_url(@wish_list_item)
    click_on "Edit this wish list item", match: :first

    click_on "Update Wish list item"

    assert_text "Wish list item was successfully updated"
    click_on "Back"
  end

  test "should destroy Wish list item" do
    visit wish_list_item_url(@wish_list_item)
    click_on "Destroy this wish list item", match: :first

    assert_text "Wish list item was successfully destroyed"
  end
end
