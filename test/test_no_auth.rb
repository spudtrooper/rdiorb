require 'test/unit'
require File.dirname(__FILE__) + '/../lib/rdio'
include Rdio

class TestNoAuth < Test::Unit::TestCase

  def test_find_by_email
    Rdio::reset
    email = 'jeff@jeffpalm.com'
    user = User.find_by_email email
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

end
