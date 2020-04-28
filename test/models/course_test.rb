require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "should have owner" do
    course = create(:course)
    course.owner = nil
    assert_not course.valid?
    assert course.errors[:owner].any?
  end
end
