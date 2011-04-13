require 'test/unit'
require File.dirname(__FILE__) + '/../lib/rdio'

class TestNoAuthNoInclude < Test::Unit::TestCase

  def test_find_by_email
    Rdio::reset
    user = Rdio::User.current
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

end
