require "test_helper"

class CourseSectionsChannelTest < ActionCable::Channel::TestCase
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in create(:admin_profile).user
  end

  # test "subscribes" do
  #   subscribe
  #   assert subscription.confirmed?
  # end
end
