require 'test_helper'

class EditPasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get edit_passwords_edit_url
    assert_response :success
  end

  test "should get update" do
    get edit_passwords_update_url
    assert_response :success
  end

end
