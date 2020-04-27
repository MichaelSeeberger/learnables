class StudentProfilePolicy < ApplicationPolicy
  def show?
    super or record.user == user
  end
end
