class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      #scope.with_roles([:admin, :editor, :user], user)
      scope.where(owner_id: user.id)
    end
  end

  #def index?
  #  super
  #end

  def create?
    user.staff_profile_id.present?
  end

  def show?
    user.staff_profile == record.owner or super
  end
end