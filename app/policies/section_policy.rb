class SectionPolicy < ApplicationPolicy
  def index?
    user.staff_profile_id.present? or super
  end

  def create?
    user.staff_profile_id.present? or super
  end

  def show?
    record.course.owner == user.staff_profile or super
  end
end