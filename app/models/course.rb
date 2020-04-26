class Course < ApplicationRecord
  resourcify

  belongs_to :owner, class_name: 'StaffProfile', foreign_key: :owner_id
  has_rich_text :description
end
