require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  test "should have unique position in course" do
    course = create(:course)
    section1 = create(:section, course: course, position: 1)
    section2 = create(:section, course: course, position: 2)

    assert section1.valid? and section2.valid?
    section2.position = section1.position
    assert_not section2.valid?
  end

  test "should allow same position on different courses" do
    section1 = create(:section, course: create(:course), position: 1)
    section2 = create(:section, course: create(:course), position: 2)

    section2.position = 1

    assert section1.valid? and section2.valid?
    assert section2.save
  end

  test "should have unique titles in same course" do
    course = create(:course)
    section1 = create(:section, course: course, title: 'My Title', position: 1)
    section2 = create(:section, course: course, title: 'My Title 2', position: 2)

    assert section1.valid? and section2.valid?

    section2.title = section1.title
    assert_not section2.valid?
  end

  test "should allow same title in different courses" do
    section1 = create(:section, course: create(:course))
    section2 = create(:section, course: create(:course))

    section2.title = section1.title

    assert section1.valid? and section2.valid?
    assert section2.save
  end

  test "should have a title" do
    section = create(:section, course: create(:course))
    section.title = ""
    assert_not section.valid?
  end
end
