class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :trackable

  belongs_to :staff_profile, optional: true
  belongs_to :student_profile, optional: true


  after_create :assign_default_role

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  def profile
    if self.staff_profile_id.nil?
      self.student_profile
    else
      self.staff_profile
    end
  end
end
