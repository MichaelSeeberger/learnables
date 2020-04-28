require 'test_helper'

class SectionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def assert_redirect_to_sign_in
    assert_redirected_to new_user_session_path
  end

  setup do
    course = create(:course)
    @section = create(:section, course: course)

    @unsaved_section = build(:section)
    @valid_new_params = {
        course_id: create(:course).id,
        position: @unsaved_section.position,
        description: @unsaved_section.description,
        title: @unsaved_section.title
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
      get sections_url
      assert_response :success
    end

    test "should get new" do
      get new_section_url
      assert_response :success
    end

    test "should create section" do
      assert_difference('Section.count') do
        post sections_url, params: {section: @valid_new_params}
      end

      assert_redirected_to section_url(Section.last)
    end

    test "should show section" do
      get section_url(@section)
      assert_response :success
    end

    test "should get edit" do
      get edit_section_url(@section)
      assert_response :success
    end

    test "should update section" do
      patch section_url(@section), params: {section: @valid_new_params}
      assert_redirected_to section_url(@section)
    end

    test "should destroy section" do
      assert_difference('Section.count', -1) do
        delete section_url(@section)
      end

      assert_redirected_to sections_url
    end
  end

  class NotSignedInContext < SectionsControllerTest
    test "should get index" do
      get sections_url
      assert_redirect_to_sign_in
    end

    test "should get new" do
      get new_section_url
      assert_redirect_to_sign_in
    end

    test "should create section" do
      assert_no_difference('Section.count') do
        post sections_url, params: {section: @valid_new_params}
      end

      assert_redirect_to_sign_in
    end

    test "should show section" do
      get section_url(@section)
      assert_redirect_to_sign_in
    end

    test "should get edit" do
      get edit_section_url(@section)
      assert_redirect_to_sign_in
    end

    test "should update section" do
      patch section_url(@section), params: {section: @valid_new_params}
      assert_redirect_to_sign_in
    end

    test "should destroy section" do
      assert_no_difference('Section.count', -1) do
        delete section_url(@section)
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
        get sections_url
      end
    end

    test "should get new" do
      assert_raises Pundit::NotAuthorizedError do
        get new_section_url
      end
    end

    test "should create section" do
      assert_no_difference('Section.count') do
        assert_raises Pundit::NotAuthorizedError do
          post sections_url, params: {section: @valid_new_params}
        end
      end
    end

    test "should show section" do
      assert_raises Pundit::NotAuthorizedError do
        get section_url(@section)
      end
    end

    test "should get edit" do
      assert_raises Pundit::NotAuthorizedError do
        get edit_section_url(@section)
      end
    end

    test "should update section" do
      assert_raises Pundit::NotAuthorizedError do
        patch section_url(@section), params: {section: @valid_new_params}
      end
    end

    test "should destroy section" do
      assert_no_difference('Section.count', -1) do
        assert_raises Pundit::NotAuthorizedError do
          delete section_url(@section)
        end
      end
    end
  end
end
