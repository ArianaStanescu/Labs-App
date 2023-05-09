require "test_helper"

class Users2ControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users2_index_url
    assert_response :success
  end
end
