require 'test/unit'
require File.dirname(__FILE__) + '/../lib/rdio'

class TestNil < Test::Unit::TestCase

  def test_nil
    assert_not_nil Rdio::api
  end
  
end
