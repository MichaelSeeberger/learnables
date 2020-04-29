require 'test_helper'

class StudentProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @student_profile = create(:student_profile)

    @valid_student_params = {
        name: 'lisa',
        user_attributes: {
            email: 'brand@new.email',
            password: 'password',
            password_confirmation: 'password'
        }
    }
  end

  class AdminContext < StudentProfilesControllerTest
    def setup
      super

      @admin = create(:admin_profile).user
      sign_in @admin
    end

    test "should get index" do
      get student_profiles_url
      assert_response :success
    end

    test "should get new" do
      get new_student_profile_url
      assert_response :success
    end

    test "should create student_profile" do
      assert_difference('StudentProfile.count') do
        post student_profiles_url, params: {student_profile: @valid_student_params}
      end

      assert_redirected_to student_profile_url(StudentProfile.last)
    end

    test "should create user with student_profile" do
      assert_difference('User.count') do
        post student_profiles_url, params: {student_profile: @valid_student_params}
      end
    end

    test "should not create student_profile when user fails to be created" do
      assert_no_difference('StudentProfile.count') do
        assert_no_difference('User.count') do
          post student_profiles_url, params: {student_profile: {name: 'Hans'}}
        end
      end
    end

    test "should show student_profile" do
      get student_profile_url(@student_profile)
      assert_response :success
    end

    test "should get edit" do
      get edit_student_profile_url(@student_profile)
      assert_response :success
    end

    test "should update student_profile" do
      patch student_profile_url(@student_profile), params: {student_profile: {name: @valid_student_params[:name]}}
      assert_redirected_to student_profile_url(@student_profile)
    end

    test "should destroy student_profile" do
      assert_difference('StudentProfile.count', -1) do
        delete student_profile_url(@student_profile)
      end

      assert_redirected_to student_profiles_url
    end
  end

  class StudentContext < StudentProfilesControllerTest
    def setup
      super

      @student = create(:student_profile).user
      sign_in @student
    end

    test "should not get index" do
      assert_raises Pundit::NotAuthorizedError do
        get student_profiles_url
      end
    end

    test "should not get new" do
      assert_raises Pundit::NotAuthorizedError do
        get new_student_profile_url
      end
    end

    test "should not create student_profile" do
      assert_no_difference('StudentProfile.count') do
        assert_raises Pundit::NotAuthorizedError do
          post student_profiles_url, params: {student_profile: @valid_student_params}
        end
      end
    end

    test "should not create user with student_profile" do
      assert_no_difference('User.count') do
        assert_raises Pundit::NotAuthorizedError do
          post student_profiles_url, params: {student_profile: @valid_student_params}
        end
      end
    end

    test "should not show student_profile" do
      assert_raises Pundit::NotAuthorizedError do
        get student_profile_url(@student_profile)
      end
    end

    test "should not get edit" do
      assert_raises Pundit::NotAuthorizedError do
        get edit_student_profile_url(@student_profile)
      end
    end

    test "should not update student_profile" do
      assert_raises Pundit::NotAuthorizedError do
        patch student_profile_url(@student_profile), params: {student_profile: {name: @valid_student_params[:name]}}
      end
    end

    test "should not destroy student_profile" do
      assert_no_difference('StudentProfile.count') do
        assert_raises Pundit::NotAuthorizedError do
          delete student_profile_url(@student_profile)
        end
      end
    end
  end

  class NotSignedInContext < StudentProfilesControllerTest
    test "should redirect to sign in and not get index" do
      get student_profiles_url
      assert_redirected_to new_user_session_url
    end

    test "should redirect to sign in and not get new" do
      get new_student_profile_url
      assert_redirected_to new_user_session_url
    end

    test "should redirect to sign in and not create student_profile" do
      assert_no_difference('StudentProfile.count') do
        post student_profiles_url, params: {student_profile: @valid_student_params}
      end

      assert_redirected_to new_user_session_url
    end

    test "should redirect to sign in and not create user with student_profile" do
      assert_no_difference('User.count') do
        post student_profiles_url, params: {student_profile: @valid_student_params}
      end

      assert_redirected_to new_user_session_url
    end

    test "should redirect to sign in and not show student_profile" do
      get student_profile_url(@student_profile)
      assert_redirected_to new_user_session_url
    end

    test "should redirect to sign in and not get edit" do
      get edit_student_profile_url(@student_profile)
      assert_redirected_to new_user_session_url
    end

    test "should redirect to sign in and not update student_profile" do
      patch student_profile_url(@student_profile), params: {student_profile: {name: @valid_student_params[:name]}}
      assert_redirected_to new_user_session_url
    end

    test "should redirect to sign in and not destroy student_profile" do
      assert_no_difference('StudentProfile.count') do
        delete student_profile_url(@student_profile)
      end

      assert_redirected_to new_user_session_url
    end
  end
end
