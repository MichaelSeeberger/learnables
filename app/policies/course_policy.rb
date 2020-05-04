class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.staff?
        if user.has_role? :admin, Course
          scope.all
        else
          sql = """
          SELECT courses.*
          FROM courses
          LEFT JOIN roles
            ON
                (roles.resource_type='Course' OR roles.resource_type IS NULL)
            AND (roles.resource_id IS NULL OR roles.resource_id=courses.id OR courses.owner_id=:staff_profile_id)
            AND (roles.name IN ('admin', 'editor', 'viewer'))
          LEFT JOIN users_roles
            ON roles.id=users_roles.role_id
          LEFT JOIN users
            ON users.id=users_roles.user_id
          WHERE users_roles.user_id=:user_id
          GROUP BY courses.id
          """
          scope.find_by_sql([sql, {staff_profile_id: user.staff_profile_id, user_id: user.id}])
        end
      else
        scope.none
      end
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

  def rearrange_sections?
    edit?
  end

  protected

  def is_owner
    user.staff_profile == record.owner
  end
end