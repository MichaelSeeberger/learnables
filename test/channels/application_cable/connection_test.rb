require "test_helper"

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
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

  test "connection is established with login" do
    user = create(:staff_profile).user
    connect_with_user user
    assert_equal connection.current_user, user
  end

  private

  def connect_with_user(user)
    connect env: {'warden' => FakeEnv.new(user)}
  end

  class FakeEnv
    attr_reader :user

    def initialize(user)
      @user = user
    end
  end
end
