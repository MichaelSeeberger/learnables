require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  class NotSignedInContext < HomeControllerTest
    test "index should redirect to sign in" do
      get root_url
      assert_redirected_to new_user_session_url
    end
  end

  class AdminContext < HomeControllerTest
    def setup
      super
      sign_in create(:admin_profile).user
    end
    test "should get index" do
      get root_url
      assert_response :success
    end
  end
end
