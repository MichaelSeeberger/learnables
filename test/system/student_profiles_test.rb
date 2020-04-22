require "application_system_test_case"

class StudentProfilesTest < ApplicationSystemTestCase
  setup do
    @student_profile = student_profiles(:one)
  end

  test "visiting the index" do
    visit student_profiles_url
    assert_selector "h1", text: "Student Profiles"
  end

  test "creating a Student profile" do
    visit student_profiles_url
    click_on "New Student Profile"

    fill_in "Name", with: @student_profile.name
    fill_in "User", with: @student_profile.user_id
    click_on "Create Student profile"

    assert_text "Student profile was successfully created"
    click_on "Back"
  end

  test "updating a Student profile" do
    visit student_profiles_url
    click_on "Edit", match: :first

    fill_in "Name", with: @student_profile.name
    fill_in "User", with: @student_profile.user_id
    click_on "Update Student profile"

    assert_text "Student profile was successfully updated"
    click_on "Back"
  end

  test "destroying a Student profile" do
    visit student_profiles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Student profile was successfully destroyed"
  end
end
