require 'pundit_helper'

# These tests serve more as a documentation of which roles can do what for the default policy implementation.
# They do not serve as an excuse to not implement the concrete tests.
class ApplicationPolicyTest < PolicyTestCase
  def setup
    super
    @user = create(:user)
    @record = create(:course) # Test with a course. could be anything though.
    @available_actions = [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  def teardown
    super
    @user.roles = []
  end

  class StaffUserContext < ApplicationPolicyTest
    def setup
      super
      staff_profile = create(:staff_profile, user: @user)
    end

    def test_admin
      @user.add_role :admin, Course
      assert_permissions(@user, @record, @available_actions,
                         index: true,
                         show: true,
                         new: true,
                         create: true,
                         edit: true,
                         update: true,
                         destroy: true
      )
    end

    def test_editor
      @user.add_role :editor, Course
      assert_permissions(@user, @record, @available_actions,
                         index: true,
                         show: true,
                         new: false,
                         create: false,
                         edit: true,
                         update: true,
                         destroy: false
      )
    end

    def test_user
      @user.add_role :user, Course
      assert_permissions(@user, @record, @available_actions,
                         index: true,
                         show: true,
                         new: false,
                         create: false,
                         edit: false,
                         update: false,
                         destroy: false
      )
    end
  end

  class StudentUserContext < ApplicationPolicyTest
    def setup
      super
      student_profile = create(:student_profile, user: @user)
    end

    def test_no_roles
      assert_permissions(@user, @record, @available_actions,
                         index: false,
                         show: false,
                         new: false,
                         create: false,
                         edit: false,
                         update: false,
                         destroy: false
      )
    end
  end

  protected
  def policy_class
    ApplicationPolicy
  end
end