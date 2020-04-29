require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @course = create(:course)
  end

  class AdminContext < CoursesControllerTest
    def setup
      super
      @admin = create(:admin_profile).user
      sign_in @admin
    end

    test "should get index" do
      get courses_url
      assert_response :success
    end

    test "should get new" do
      get new_course_url
      assert_response :success
    end

    test "should create course" do
      assert_difference('Course.count') do
        post courses_url, params: {course: {owner_id: @course.owner_id, title: @course.title}}
      end

      assert_redirected_to course_url(Course.last)
    end

    test "should show course" do
      get course_url(@course)
      assert_response :success
    end

    test "should get edit" do
      get edit_course_url(@course)
      assert_response :success
    end

    test "should update course" do
      patch course_url(@course), params: {course: {owner_id: @course.owner_id, title: @course.title}}
      assert_redirected_to course_url(@course)
    end

    test "should destroy course" do
      assert_difference('Course.count', -1) do
        delete course_url(@course)
      end

      assert_redirected_to courses_url
    end
  end

  class StudentContext < CoursesControllerTest
    def setup
      super
      @student = create(:student_profile).user
      sign_in @student
    end

    test "should not get index" do
      get courses_url
      assert_response :success
    end

    test "should not get new" do
      assert_raises Pundit::NotAuthorizedError do
        get new_course_url
      end
    end

    test "should not create course" do
      assert_no_difference('Course.count') do
        assert_raises Pundit::NotAuthorizedError do
          post courses_url, params: {course: {owner_id: @course.owner_id, title: @course.title}}
        end
      end
    end

    test "should not show course" do
      assert_raises Pundit::NotAuthorizedError do
        get course_url(@course)
      end
    end

    test "should not get edit" do
      assert_raises Pundit::NotAuthorizedError do
        get edit_course_url(@course)
      end
    end

    test "should not update course" do
      assert_raises Pundit::NotAuthorizedError do
        patch course_url(@course), params: {course: {owner_id: @course.owner_id, title: @course.title}}
      end
    end

    test "should not destroy course" do
      assert_no_difference('Course.count') do
        assert_raises Pundit::NotAuthorizedError do
          delete course_url(@course)
        end
      end
    end
  end

  class NotSignedInContext < CoursesControllerTest
    test "index should redirect to sign in" do
      get courses_url
      assert_redirected_to new_user_session_url
    end

    test "new should redirect to sign in" do
      get new_course_url
      assert_redirected_to new_user_session_url
    end

    test "create course should redirect to sign in" do
      assert_no_difference('Course.count') do
        post courses_url, params: {course: {owner_id: @course.owner_id, title: @course.title}}
      end

      assert_redirected_to new_user_session_url
    end

    test "show should redirect to sign in" do
      get course_url(@course)
      assert_redirected_to new_user_session_url
    end

    test "get should should redirect to sign in" do
      get edit_course_url(@course)
      assert_redirected_to new_user_session_url
    end

    test "update should redirect to sign in" do
      patch course_url(@course), params: {course: {owner_id: @course.owner_id, title: @course.title}}
      assert_redirected_to new_user_session_url
    end

    test "destroy should redirect to sign in" do
      assert_no_difference('Course.count', -1) do
        delete course_url(@course)
      end

      assert_redirected_to new_user_session_url
    end
  end
end
