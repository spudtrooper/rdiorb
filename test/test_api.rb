require 'test/unit'
require File.dirname(__FILE__) + '/../lib/rdio'

class TestUser < Test::Unit::TestCase

  def test_find_user_by_email
    email = 'jeff@jeffpalm.com'
    user = Rdio::api.findUserByEmail email
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_find_user_by_vanity_name
    name = 'spudtrooper'
    user = Rdio::api.findUserByVanityName name
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end
  
end
