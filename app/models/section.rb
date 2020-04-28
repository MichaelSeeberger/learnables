class Section < ApplicationRecord
  validates_uniqueness_of :position, scope: :course
  validates :title, presence: true, uniqueness: {scope: :course}

  belongs_to :course
end
