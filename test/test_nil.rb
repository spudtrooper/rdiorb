require File.dirname(__FILE__) + '/common'

class TestNil < Test::Unit::TestCase

  def test_nil
    assert_not_nil Rdio::api
  end
  
end
