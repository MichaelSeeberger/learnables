class UserPolicy < ApplicationPolicy
  def edit_password?
    update_password?
  end

  def update_password?
    not user.nil?
  end

  def edit_email?
    update_email?
  end

  def update_email?
    not user.staff_profile_id.nil?
  end
end