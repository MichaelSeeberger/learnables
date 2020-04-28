require 'pundit_helper'

class StaffProfilePolicyTest < PolicyTestCase
  def setup
    super
    @user = create(:user)
    @record = create(:staff_profile)
    @available_actions = [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  def teardown
    super
    @user.roles = []
  end

  class StaffUserContext < StaffProfilePolicyTest
    def setup
      super
      # make sure the user is a staff member
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
                         destroy: true
      )
    end

    def test_staff_profile_admin
      @user.add_role :admin, StaffProfile
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

    def test_global_editor
      @user.add_role :editor
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

    def test_editor
      @user.add_role :editor, StaffProfile
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

    def test_global_user
      @user.add_role :user
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

    def test_user
      @user.add_role :user, StaffProfile
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

    def test_user_own_profile
      @user.add_role :user, StaffProfile
      assert_permissions(@user, create(:staff_profile, user: @user), @available_actions,
                         index: true,
                         show: true,
                         new: false,
                         create: false,
                         edit: true,
                         update: true,
                         destroy: true
      )
    end
  end

  class StudentUserContext < StaffProfilePolicyTest
    def setup
      super
      student_profile = create(:student_profile, user: @user)
    end

    def test_global_admin
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

  protected def policy_class
    StaffProfilePolicy
  end
end
