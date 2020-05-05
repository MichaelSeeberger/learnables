require "test_helper"

class CourseSectionsChannelTest < ActionCable::Channel::TestCase
  def setup
    @course = create(:course)
  end

  test "subscribes" do
    stub_connection current_user: create(:admin_profile).user

    subscribe id: @course.id
    assert subscription.confirmed?
    assert_has_stream_for @course
  end

  test "subscribes to own course" do
    stub_connection current_user: @course.owner.user

    subscribe id: @course.id
    assert subscription.confirmed?
    assert_has_stream_for @course
  end

  test "rejects subscription without authorization" do
    stub_connection current_user: create(:staff_profile).user

    subscribe id: @course.id
    assert subscription.rejected?
  end
end
