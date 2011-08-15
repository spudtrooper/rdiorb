require File.dirname(__FILE__) + '/common'

class TestUser < RdioTestCase

  def test_api
    api = Rd::io
    assert_not_nil api
  end
  
end
