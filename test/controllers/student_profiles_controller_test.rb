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

    admin_profile = create(:admin_profile)
    @admin = admin_profile.user
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
