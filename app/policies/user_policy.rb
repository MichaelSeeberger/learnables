class UserPolicy < ApplicationPolicy
  def edit_password?
    not user.nil?
  end

  def update_password?
    edit_password?
  end

  def edit_email?
    not user.staff_profile_id.nil?
  end

  def update_email?
    update_email?
  end
end