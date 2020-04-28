require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    admin_profile = create(:admin_profile)
    @admin = admin_profile.user
    sign_in @admin
  end

  test "should get edit_password" do
    get edit_password_url
    assert_response :success
  end

  test "should update password" do
    patch edit_password_url, params: {users: {password: 'mypassword', password_confirmation: 'mypassword', current_password: 'password'}}
    assert_redirected_to root_url
    assert @admin.valid_password?('mypassword')
  end

  test "should get edit_email" do
    get edit_email_url
    assert_response :success
  end

  test "should update email" do
    assert_changes '@admin.email' do
      patch edit_email_url, params: {users: {email: 'my@email.com', password: 'password'}}
    end
    assert_redirected_to root_url
  end
end
