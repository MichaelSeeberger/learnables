require 'pundit_helper'

class SectionPolicyTest < PolicyTestCase
  def setup
    super
    @user = create(:user)
    @course = create(:course)
    @record = create(:section, course: @course)
    @available_actions = [:show, :new, :create, :edit, :update, :destroy]
  end

  def teardown
    super
    @user.roles = []
  end

  class StaffUserContext < SectionPolicyTest
    def setup
      super
      staff_profile = create(:staff_profile, user: @user)
    end

    def test_global_admin
      @user.add_role :admin
      assert_permissions(@user, @record, @available_actions,
                         show: true,
                         new: true,
                         create: true,
                         edit: true,
                         update: true,
                         destroy: true
      )
    end

    def test_course_admin
      @user.add_role :admin, Course
      assert_permissions(@user, @record, @available_actions,
                         show: true,
                         new: true,
                         create: true,
                         edit: true,
                         update: true,
                         destroy: true
      )
    end

    def test_global_editor
      @user.add_role :editor
      assert_permissions(@user, @record, @available_actions,
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
                         show: true,
                         new: true,
                         create: true,
                         edit: true,
                         update: true,
                         destroy: true
      )
    end

    def test_global_user
      @user.add_role :user
      assert_permissions(@user, @record, @available_actions,
                         show: true,
                         new: false,
                         create: false,
                         edit: false,
                         update: false,
                         destroy: false
      )
    end

    def test_user
      @user.add_role :user, Course
      assert_permissions(@user, @record, @available_actions,
                         show: true,
                         new: false ,
                         create: false,
                         edit: false,
                         update: false,
                         destroy: false
      )
    end

    def test_user_own_course
      @record.course = create(:course, owner: @user.staff_profile)
      assert_permissions(@user, @record, @available_actions,
                         show: true,
                         new: true,
                         create: true,
                         edit: true,
                         update: true,
                         destroy: true
      )
    end
  end

  class StudentUserContext < SectionPolicyTest
    def setup
      super
      student_profile = create(:student_profile, user: @user)
    end

    def test_access_for_assigned_course
      skip('Implement feature: assign course to student')
      assert_permissions(@user, @record, @available_actions,
                         show: true,
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
    SectionPolicy
  end
end
