class StudentProfile < ApplicationRecord
  resourcify

  validates_presence_of :name

  has_one :user, dependent: :destroy

  accepts_nested_attributes_for :user
end
