require File.dirname(__FILE__) + '/common'
include Rdio

class TestCall < RdioTestCase

  def test_get
    c = Call.new
    args = ['get', 'keys=t7609753']
    have = c.real_main args
    assert_equal true, !!have.index(/"ok"/)
  end

  def test_get_indent
    c = Call.new
    args = ['get', 'keys=t7609753','-i']
    have = c.real_main args
    assert_equal true, !!have.index(/"ok"/)
  end
  
end
