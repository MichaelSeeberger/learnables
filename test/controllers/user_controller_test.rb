require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get edit_password" do
    get user_edit_password_url
    assert_response :success
  end

  test "should get update_password" do
    get user_update_password_url
    assert_response :success
  end

end
