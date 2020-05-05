require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
  end

  test "get staff profile" do
    staff_profile = create(:staff_profile, user: @user)
    assert_equal staff_profile, @user.profile
  end

  test "get student profile" do
    student_profile = create(:student_profile, user: @user)
    assert_equal student_profile, @user.profile
  end

  test "staff? returns true only when having student profile" do
    create(:student_profile, user: @user)
    assert @user.student?
  end

  test "student? returns true only when having student profile" do
    create(:staff_profile, user: @user)
    assert @user.staff?
  end
end
