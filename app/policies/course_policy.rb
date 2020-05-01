class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      #scope.with_roles([:admin, :editor, :user], user)
      scope.where(owner_id: user.staff_profile_id)
    end
  end

  def index?
    true
  end

  def create?
    user_has_any_role?(:admin, :editor, :user) or user.staff?
  end

  def update?
    super or is_owner
  end

  def show?
    super or is_owner
  end

  def destroy?
    super or is_owner
  end

  def show_sections?
    show?
  end

  protected

  def is_owner
    user.staff_profile == record.owner
  end
end