require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "should have owner" do
    course = create(:course)
    course.owner = nil
    assert_not course.valid?
    assert course.errors[:owner].any?
  end

  test "should move from to with from > to" do
    course = create(:course)
    sections = []
    num_items = 5
    num_items.times do |i|
      sections << create(:section, course: course, position: i)
    end
    from = 3
    to = 1
    course.move_section! from, to
    sections.each_with_index do |section, i|
      section.reload
      if i == from
        assert_equal section.position, to, "expected position #{from} to be moved to #{to}, is at #{section.position}"
      elsif i >= to and i < from
        assert_equal section.position, i + 1, "expected position #{i} to be moved to #{i + 1}, is at #{section.position}"
      else
        assert_equal section.position, i, "expected position #{i} to not have changed section #{i}, is at #{section.position}"
      end
    end
  end

  test "should move from to with from < to" do
    course = create(:course)
    sections = []
    num_items = 5
    num_items.times do |i|
      sections << create(:section, course: course, position: i)
    end

    from = 1
    to = 3
    course.move_section! from, to
    sections.each_with_index do |section, i|
      section.reload
      if i == from
        assert_equal section.position, to, "expected position #{i} to be moved to #{to}, is at #{section.position}"
      elsif i > from and i <= to
        assert_equal section.position, i - 1, "expected position #{to} to be moved to #{to - 1}, is at #{section.position}"
      else
        assert_equal section.position, i, "expected position #{i} to not have been changed, is at #{section.position}"
      end
    end

  end
end
