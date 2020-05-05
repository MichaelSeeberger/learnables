require 'test_helper'

class SectionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def assert_redirect_to_sign_in
    assert_redirected_to new_user_session_path
  end

  setup do
    @course = create(:course)
    @section = create(:section, course: @course)

    @unsaved_section = build(:section)
    @valid_new_params = {
        position: @unsaved_section.position,
        description: @unsaved_section.description,
        title: @unsaved_section.title
    }

    @invalid_new_params = {
        position: @unsaved_section.position,
        description: @unsaved_section.description,
        title: ''
    }
  end

  class AdminContext < SectionsControllerTest
    def setup
      super
      admin_profile = create(:admin_profile)
      @admin = admin_profile.user
      sign_in @admin
    end

    test "should get index" do
      get course_sections_url(@course)
      assert_response :success
    end

    test "should get new" do
      get new_course_section_url(@course)
      assert_response :success
    end

    test "should create section" do
      assert_difference('Section.count') do
        post course_sections_url(@course), params: {section: @valid_new_params}
      end

      assert_redirected_to course_section_url(@course, Section.last)
    end

    test "should not create section with invalid params" do
      assert_no_difference('Section.count') do
        post course_sections_url(@course), params: {section: @invalid_new_params}
      end
    end

    test "should show section" do
      get course_section_url(@course, @section)
      assert_response :success
    end

    test "should get edit" do
      get edit_course_section_url(@course, @section)
      assert_response :success
    end

    test "should update section" do
      patch course_section_url(@course, @section), params: {section: @valid_new_params}
      assert_redirected_to course_section_url(@course, @section)
    end

    test "should not update with invalid section params" do
      assert_no_changes '@section.title' do
        patch course_section_url(@course, @section), params: {section: @invalid_new_params}
        @section.reload
      end
    end

    test "should destroy section" do
      assert_difference('Section.count', -1) do
        delete course_section_url(@course, @section)
      end

      assert_redirected_to course_sections_url(@course)
    end
  end

  class NotSignedInContext < SectionsControllerTest
    test "should get index" do
      get course_sections_url(@course)
      assert_redirect_to_sign_in
    end

    test "should get new" do
      get new_course_section_url(@course)
      assert_redirect_to_sign_in
    end

    test "should create section" do
      assert_no_difference('Section.count') do
        post course_sections_url(@course), params: {section: @valid_new_params}
      end

      assert_redirect_to_sign_in
    end

    test "should show section" do
      get course_section_url(@course, @section)
      assert_redirect_to_sign_in
    end

    test "should get edit" do
      get edit_course_section_url(@course, @section)
      assert_redirect_to_sign_in
    end

    test "should update section" do
      patch course_section_url(@course, @section), params: {section: @valid_new_params}
      assert_redirect_to_sign_in
    end

    test "should destroy section" do
      assert_no_difference('Section.count', -1) do
        delete course_section_url(@course, @section)
      end

      assert_redirect_to_sign_in
    end
  end

  class StudentContext < SectionsControllerTest
    def setup
      super
      student_profile = create(:student_profile)
      @student = student_profile.user
      sign_in @student
    end

    test "should get index" do
      assert_raises Pundit::NotAuthorizedError do
        get course_sections_url(@course)
      end
    end

    test "should get new" do
      assert_raises Pundit::NotAuthorizedError do
        get new_course_section_url(@course)
      end
    end

    test "should create section" do
      assert_no_difference('Section.count') do
        assert_raises Pundit::NotAuthorizedError do
          post course_sections_url(@course), params: {section: @valid_new_params}
        end
      end
    end

    test "should show section" do
      assert_raises Pundit::NotAuthorizedError do
        get course_section_url(@course, @section)
      end
    end

    test "should get edit" do
      assert_raises Pundit::NotAuthorizedError do
        get edit_course_section_url(@course, @section)
      end
    end

    test "should update section" do
      assert_raises Pundit::NotAuthorizedError do
        patch course_section_url(@course, @section), params: {section: @valid_new_params}
      end
    end

    test "should destroy section" do
      assert_no_difference('Section.count', -1) do
        assert_raises Pundit::NotAuthorizedError do
          delete course_section_url(@course, @section)
        end
      end
    end
  end
end
