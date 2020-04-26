class StaffProfile < ApplicationRecord
  resourcify
  has_one :user, dependent: :destroy
  has_many :courses, foreign_key: :owner_id

  accepts_nested_attributes_for :user
end
