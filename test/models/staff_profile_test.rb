require 'test_helper'

class StaffProfileTest < ActiveSupport::TestCase
  test "should have name present" do
    staff_profile = create(:staff_profile)
    staff_profile.name = ""
    assert_not staff_profile.valid?
    assert staff_profile.errors[:name].any?
  end
end
