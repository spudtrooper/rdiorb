require File.dirname(__FILE__) + '/common'
include Rdio

#
# https://github.com/spudtrooper/rdiorb/issues/10
#
class TestJewGoneWild < TestCase

  def test_search_Jewgonewild
    Rdio::reset
    key = ENV['RDIO_KEY']
    secret = ENV['RDIO_SECRET']
    rdio = Rdio::init(key,secret)
    res = rdio.search('yellow ostrich')
    assert_equal 10,res.length # should be at least 10
  end
  
end
