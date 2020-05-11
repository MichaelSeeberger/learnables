require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  class AdminContext < UserControllerTest
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
      @admin.reload
      assert @admin.valid_password?('mypassword')
    end

    test "should not update password when old password is incorrect" do
      patch edit_password_url, params: {users: {password: 'mypassword', password_confirmation: 'mypassword', current_password: 'incorrect'}}
      @admin.reload
      assert @admin.valid_password?('password')
      assert @admin.errors[:current_password].any?
    end

    test "should not update passwords if password does not match password_confirmation" do
      patch edit_password_url, params: {users: {password: 'mypassword', password_confirmation: 'not-matching', current_password: 'password'}}
      assert @admin.errors[:password_confirmation].any?
      @admin.reload
      assert @admin.valid_password?('password')
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

    test "should not update email when password is incorrect" do
      assert_no_changes '@admin.email' do
        patch edit_email_url, params: {users: {email: 'my@email.com', password: 'incorrect-password'}}
        @admin.reload
      end
      assert @admin.errors[:password].any?
    end

    test "should not update email when email is invalid" do
      assert_no_changes '@admin.email' do
        patch edit_email_url, params: {users: {email: 'email?', password: 'password'}}
        @admin.reload
      end
      assert @admin.errors[:email].any?
      assert_response :success
    end
  end

  class StudentContext < UserControllerTest
    def setup
      @student = create(:student_profile).user
      sign_in @student
    end

    test "should get edit_password" do
      get edit_password_url
      assert_response :success
    end

    test "should update password" do
      patch edit_password_url, params: {users: {password: 'mypassword', password_confirmation: 'mypassword', current_password: 'password'}}
      assert_redirected_to root_url
      assert @student.valid_password?('mypassword')
    end

    test "should not get edit_email" do
      assert_raises Pundit::NotAuthorizedError do
        get edit_email_url
      end
    end

    test "should not update email" do
      assert_no_changes '@student.email' do
        assert_raises Pundit::NotAuthorizedError do
          patch edit_email_url, params: {users: {email: 'my@email.com', password: 'password'}}
        end
      end
    end
  end

  class NotSignedInContext < UserControllerTest
    test "should redirect to sign in on get edit_password" do
      get edit_password_url
      assert_redirected_to new_user_session_path
    end

    test "should redirect to sign in on update password" do
      patch edit_password_url, params: {users: {password: 'mypassword', password_confirmation: 'mypassword', current_password: 'password'}}
      assert_redirected_to new_user_session_path
    end

    test "should redirect to sign in on get edit_email" do
      get edit_email_url
      assert_redirected_to new_user_session_path
    end

    test "should redirect to sign in on update email" do
      patch edit_email_url, params: {users: {email: 'my@email.com', password: 'password'}}
      assert_redirected_to new_user_session_path
    end
  end
end
