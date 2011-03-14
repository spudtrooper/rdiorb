require 'test/unit'
require File.dirname(__FILE__) + '/../lib/rdio'

class TestUser < Test::Unit::TestCase

  def test_api
    api = Rd::io
    assert_not_nil api
  end
  
end
