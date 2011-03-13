require File.dirname(__FILE__) + '/../test/rdio_test'

class TestUser < Test::Unit::TestCase

  def test_find_user_by_email
    email = 'jeff@jeffpalm.com'
    user = api.findUserByEmail email
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_find_user_by_vanity_name
    name = 'spudtrooper'
    user = api.findUserByVanityName name
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end
  
end
