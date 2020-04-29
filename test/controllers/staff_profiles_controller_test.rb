require 'test_helper'

class StaffProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @staff_profile = create(:staff_profile)

    @valid_staff_attributes = {
        name: @staff_profile.name,
        user_attributes: {
            email: 'brand@new.email',
            password: 'password',
            password_confirmation: 'password'
        }
    }
  end

  class AdminContext < StaffProfilesControllerTest
    def setup
      super
      admin_profile = create(:admin_profile)
      @admin = admin_profile.user
      sign_in @admin
    end

    def teardown
      @admin.roles = []
      super
    end

    test "should get index" do
      get staff_profiles_url
      assert_response :success
    end

    test "should get new" do
      get new_staff_profile_url
      assert_response :success
    end

    test "should create staff_profile" do
      assert_difference('StaffProfile.count') do
        post staff_profiles_url, params: {staff_profile: @valid_staff_attributes}
      end

      assert_redirected_to staff_profile_url(StaffProfile.last)
    end

    test "should create user with staff_profile" do
      assert_difference('User.count') do
        post staff_profiles_url, params: {staff_profile: @valid_staff_attributes}
      end
    end

    test "should not create staff_profile when user fails to be created" do
      assert_no_difference('StaffProfile.count') do
        assert_no_difference('User.count') do
          post staff_profiles_url, params: {staff_profile: {name: 'Hans'}}
        end
      end
    end

    test "should show staff_profile" do
      get staff_profile_url(@staff_profile)
      assert_response :success
    end

    test "should get edit" do
      get edit_staff_profile_url(@staff_profile)
      assert_response :success
    end

    test "should update staff_profile" do
      patch staff_profile_url(@staff_profile), params: {staff_profile: {name: @staff_profile.name}}
      assert_redirected_to staff_profile_url(@staff_profile)
    end

    test "should destroy staff_profile" do
      assert_difference('StaffProfile.count', -1) do
        delete staff_profile_url(@staff_profile)
      end

      assert_redirected_to staff_profiles_url
    end
  end

  class StudentContext < StaffProfilesControllerTest
    # This tests only that pundit is in action. _Not_ the actual policy implementation!
    def setup
      super
      @user = create(:student_profile).user
      sign_in @user
    end

    def teardown
      @user.roles = []
      super
    end

    test "should get index" do
      assert_raises Pundit::NotAuthorizedError do
        get staff_profiles_url
      end
    end

    test "should not get new" do
      assert_raises Pundit::NotAuthorizedError do
        get new_staff_profile_url
      end
    end

    test "should not create staff_profile" do
      assert_no_difference('StaffProfile.count') do
        assert_raises Pundit::NotAuthorizedError do
          post staff_profiles_url, params: {staff_profile: @valid_staff_attributes}
        end
      end
    end

    test "should not create user with staff_profile" do
      assert_no_difference('User.count') do
        assert_raises Pundit::NotAuthorizedError do
          post staff_profiles_url, params: {staff_profile: @valid_staff_attributes}
        end
      end
    end

    test "should show staff_profile" do
      assert_raises Pundit::NotAuthorizedError do
        get staff_profile_url(@staff_profile)
      end
    end

    test "should not get edit" do
      assert_raises Pundit::NotAuthorizedError do
        get edit_staff_profile_url(@staff_profile)
      end
    end

    test "should not update staff_profile" do
      assert_raises Pundit::NotAuthorizedError do
        patch staff_profile_url(@staff_profile), params: {staff_profile: {name: @staff_profile.name}}
      end
    end

    test "should not destroy staff_profile" do
      assert_no_difference('StaffProfile.count', -1) do
        assert_raises Pundit::NotAuthorizedError do
          delete staff_profile_url(@staff_profile)
        end
      end
    end
  end

  class NotSignedInContext < StaffProfilesControllerTest
    test "should get index" do
      get staff_profiles_url
      assert_redirected_to new_user_session_url
    end

    test "should not get new" do
      get new_staff_profile_url
      assert_redirected_to new_user_session_url
    end

    test "should not create staff_profile" do
      assert_no_difference('StaffProfile.count') do
        post staff_profiles_url, params: {staff_profile: @valid_staff_attributes}
      end
      assert_redirected_to new_user_session_url
    end

    test "should not create user with staff_profile" do
      assert_no_difference('User.count') do
        post staff_profiles_url, params: {staff_profile: @valid_staff_attributes}
      end
      assert_redirected_to new_user_session_url
    end

    test "should show staff_profile" do
      get staff_profile_url(@staff_profile)
      assert_redirected_to new_user_session_url
    end

    test "should not get edit" do
      get edit_staff_profile_url(@staff_profile)
      assert_redirected_to new_user_session_url
    end

    test "should not update staff_profile" do
      patch staff_profile_url(@staff_profile), params: {staff_profile: {name: @staff_profile.name}}
      assert_redirected_to new_user_session_url
    end

    test "should not destroy staff_profile" do
      assert_no_difference('StaffProfile.count', -1) do
        delete staff_profile_url(@staff_profile)
      end
      assert_redirected_to new_user_session_url
    end
  end
end
