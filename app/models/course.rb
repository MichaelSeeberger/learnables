class Course < ApplicationRecord
  resourcify

  validates :title, presence: true

  belongs_to :owner, class_name: 'StaffProfile', foreign_key: :owner_id
  has_rich_text :description

  has_many :sections

  def tidy_section_positions!
    really_tidy_positions! self.sections.order(:position).to_a
  end

  def move_section!(from, to)
    return if from == to or from < 0 or to < 0

    sections = self.sections.order(:position).to_a
    sections.insert(to, sections.delete_at(from))
    really_tidy_positions! sections
  end

  private

  def really_tidy_positions!(sections)
    Section.transaction do
      sections.each_with_index do |section, index|
        next if section.position == index

        section.position = index
        section.save! validate: false
      end
    end
    sections
  end
end
