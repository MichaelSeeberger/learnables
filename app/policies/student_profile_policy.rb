class StudentProfilePolicy < ApplicationPolicy
  def index?
    user.staff? and user_has_any_role?(:admin, :editor, :user)
  end

  def show?
    super or users_own_profile?
  end

  def update?
    super or users_own_profile?
  end

  private

  def users_own_profile?
    record.user == user
  end
end
