require File.dirname(__FILE__) + '/../test/rdio_test'

class TestUser < Test::Unit::TestCase

  def test_first_name
    email = 'jeff@jeffpalm.com'
    user = api.findUserByEmail email
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end
  
end
