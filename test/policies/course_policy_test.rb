require 'pundit_helper'

class CoursePolicyTest < PolicyTestCase
  def setup
    super
    @user = create(:user)
    @record = create(:course)
    @available_actions = [:index, :show, :new, :create, :edit, :update, :destroy, :show_sections]
  end

  def teardown
    super
    @user.roles = []
  end

  class StaffUserContext < CoursePolicyTest
    def setup
      super
      staff_profile = create(:staff_profile, user: @user)
    end

    def test_global_admin
      @user.add_role :admin
      assert_permissions(@user, @record, @available_actions,
                         index: true,
                         show: true,
                         new: true,
                         create: true,
                         edit: true,
                         update: true,
                         destroy: true,
                         show_sections: true
      )
    end

    def test_course_admin
      @user.add_role :admin, Course
      assert_permissions(@user, @record, @available_actions,
                         index: true,
                         show: true,
                         new: true,
                         create: true,
                         edit: true,
                         update: true,
                         destroy: true,
                         show_sections: true
      )
    end

    def test_global_editor
      @user.add_role :editor
      assert_permissions(@user, @record, @available_actions,
                         index: true,
                         show: true,
                         new: true,
                         create: true,
                         edit: true,
                         update: true,
                         destroy: false,
                         show_sections: true
      )
    end

    def test_editor
      @user.add_role :editor, Course
      assert_permissions(@user, @record, @available_actions,
                         index: true,
                         show: true,
                         new: true,
                         create: true,
                         edit: true,
                         update: true,
                         destroy: false,
                         show_sections: true
      )
    end

    def test_global_user
      @user.add_role :user
      assert_permissions(@user, @record, @available_actions,
                         index: true,
                         show: true,
                         new: true,
                         create: true,
                         edit: false,
                         update: false,
                         destroy: false,
                         show_sections: true
      )
    end

    def test_user
      @user.add_role :user, Course
      assert_permissions(@user, @record, @available_actions,
                         index: true,
                         show: true,
                         new: true,
                         create: true,
                         edit: false,
                         update: false,
                         destroy: false,
                         show_sections: true
      )
    end

    def test_user_own_course
      assert_permissions(@user, create(:course, owner: @user.staff_profile), @available_actions,
                         index: true,
                         show: true,
                         new: true,
                         create: true,
                         edit: true,
                         update: true,
                         destroy: true,
                         show_sections: true
      )
    end

    def test_user_no_role
      assert_permissions(@user, @record, @available_actions,
                         index: true,
                         show: false,
                         new: true,
                         create: true,
                         edit: false,
                         update: false,
                         destroy: false,
                         show_sections: false
      )
    end
  end

  class StudentUserContext < CoursePolicyTest
    def setup
      super
      student_profile = create(:student_profile, user: @user)
    end

    def test_student_access
      assert_permissions(@user, @record, @available_actions,
                         index: true,
                         show: false,
                         new: false,
                         create: false,
                         edit: false,
                         update: false,
                         destroy: false,
                         show_sections: false
      )
    end

    def test_access_for_assigned_course
      pass 'Implement access when assigned a course when the feature is implemented'
    end
  end

  protected
  def policy_class
    CoursePolicy
  end
end