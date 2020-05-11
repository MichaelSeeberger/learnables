require 'test_helper'

class StudentProfileTest < ActiveSupport::TestCase
  test "should have name present" do
    student_profile = create(:student_profile)
    student_profile.name = ""
    assert_not student_profile.valid?
    assert student_profile.errors[:name].any?
  end
end
