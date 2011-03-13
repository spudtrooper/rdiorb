require File.dirname(__FILE__) + '/../test/rdio_test'

class TestNil < Test::Unit::TestCase

  def test_null
    assert_not_nil api
  end
  
end
