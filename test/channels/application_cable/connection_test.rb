require "test_helper"

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  include Devise::Test::IntegrationHelpers
  # test "connects with cookies" do
  #   cookies.signed[:user_id] = 42
  #
  #   connect
  #
  #   assert_equal connection.user_id, "42"
  # end

  test "connection is rejected without login" do
    assert_reject_connection do
      connect
    end
  end
end
