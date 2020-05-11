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

  test "does not stream without course" do
    stub_connection current_user: create(:staff_profile).user

    subscribe
    assert_no_streams
    assert subscription.rejected?
  end

  test "does not stream with invalid course id" do
    stub_connection current_user: create(:staff_profile).user

    subscribe id: @course.id * 2
    assert_no_streams
    assert subscription.rejected?
  end

  test "change order" do
    stub_connection current_user: create(:admin_profile).user

    subscribe id: @course.id
    assert subscription.confirmed?

    sections = []
    3.times do |i|
      sections << create(:section, position: i, course: @course)
    end

    perform :move_section, from: 1, to: 2
    assert_equal sections[1].reload.position, 2
    assert_equal sections[2].reload.position, 1
  end

  test "change creates broadcast" do
    stub_connection current_user: create(:admin_profile).user

    subscribe id: @course.id
    assert subscription.confirmed?

    original_sections = []
    3.times do |i|
      original_sections << create(:section, position: i, course: @course)
    end

    assert_broadcasts(@course, 1) do
      perform :move_section, 'from': 1, 'to': 2
    end

    message = JSON.parse(broadcasts(broadcasting_for(@course))[0])
    sections = message['sections']
    assert_equal 0, sections[0]['position']
    assert_equal original_sections[0].id, sections[0]['id']

    assert_equal 1, sections[1]['position']
    assert_equal original_sections[2].id, sections[1]['id']

    assert_equal 2, sections[2]['position']
    assert_equal original_sections[1].id, sections[2]['id']
  end
end