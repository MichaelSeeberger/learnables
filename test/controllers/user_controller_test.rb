require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    admin_profile = create(:admin_profile)
    @admin = admin_profile.user
    sign_in @admin
  end

  test "should get edit_password" do
    get user_edit_password_url
    assert_response :success
  end

  test "should update password" do
    skip 'should test this'
  end

  test "should get edit_email" do
    get user_edit_email_url
    assert_response :success
  end

  test "should update email" do
    skip 'should test this'
  end

end
