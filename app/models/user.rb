class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :trackable

  belongs_to :staff_profile, optional: true
  belongs_to :student_profile, optional: true

  def profile
    if self.staff_profile_id.nil?
      self.student_profile
    else
      self.staff_profile
    end
  end

  def staff?
    self.staff_profile_id.present?
  end

  def student?
    self.student_profile_id.present?
  end
end
