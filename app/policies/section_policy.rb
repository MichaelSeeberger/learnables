class SectionPolicy < ApplicationPolicy
  def show?
    course_policy.show?
  end

  def update?
    course_policy.edit?
  end

  def create?
    course_policy.edit?
  end

  def destroy?
    course_policy.edit?
  end

  def course_policy
    CoursePolicy.new(user, record.course)
  end
end