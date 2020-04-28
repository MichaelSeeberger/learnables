class StaffProfilePolicy < ApplicationPolicy
  def update?
    super or current_users_profile?
  end

  def destroy?
    super or current_users_profile?
  end

  private
  def current_users_profile?
    user.staff_profile == record
  end
end
