require 'test_helper'

class PolicyTestCase < ActiveSupport::TestCase
  def assert_permissions(current_user, record, available_actions, permissions_hash = {})
    permissions_hash.each do |action, should_be_permitted|
      if should_be_permitted
        assert_permit current_user, record, action
      else
        refute_permit current_user, record, action
      end
    end

    # Make sure all available actions were tested
    unused_actions = @available_actions - permissions_hash.keys
    assert unused_actions.empty?, "The following actions were not tested: #{ unused_actions }"

    # Make sure tested actions were in available_actions
    unavailable_actions = permissions_hash.keys - @available_actions
    assert unavailable_actions.empty?, "The following actions were tested, but not in available_actions: #{ unavailable_actions }"
  end

  def assert_permit(current_user, record, action)
    assert permit(current_user, record, action), "User #{ current_user } should be permitted #{ action } on #{ record }, but isn't permitted"
  end

  def refute_permit(current_user, record, action)
    refute permit(current_user, record, action), "User #{ current_user } should NOT be permitted #{ action } on #{ record }, but is permitted"
  end

  def permit(current_user, record, action)
    self.policy(current_user, record).public_send("#{ action.to_s }?")
  end

  private

  def policy(current_user, record)
    policy_class.new(current_user, record)
  end

  def policy_class
    @policy_class ||= self.class.to_s.gsub(/Test/, "").constantize
  end
end
