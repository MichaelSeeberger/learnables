require 'test_helper'

class Users::SessionControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "sign out should redirect to sign in page" do
    @user = create(:user)
    sign_in @user
    delete destroy_user_session_url
    assert_redirected_to new_user_session_url
  end
end
