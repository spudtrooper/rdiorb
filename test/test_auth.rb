require 'test/unit'
require File.dirname(__FILE__) + '/../lib/rdio'
include Rdio

class TestAuth < RdioTestCase

  def test_current
    Rdio::reset
    user = User.current
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

end
