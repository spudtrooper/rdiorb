require File.dirname(__FILE__) + '/common'
require File.dirname(__FILE__) + '/../lib/rdio'
include Rdio

class TestUser3 < RdioTestCase

  def test_is_trial
    user = User.current 'isTrial'
    assert_equal false,user.trial?
    assert_equal false,user.is_trial
  end

  def test_is_subscriber
    user = User.current 'isSubscriber'
    assert_equal true,user.subscriber?
    assert_equal true,user.is_subscriber
  end

  def test_is_unlimited
    user = User.current 'isUnlimited'
    assert_equal true,user.unlimited?
    assert_equal true,user.is_unlimited
  end
  
end
