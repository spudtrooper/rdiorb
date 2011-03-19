require File.dirname(__FILE__) + '/common'
require File.dirname(__FILE__) + '/../lib/rdio'
include Rdio

class TestSearch < Test::Unit::TestCase

  def test_search
    res = Search.search 'Kanye West'
    assert_at_least 10,res.artist_count,'artist_count'
    assert_at_least 10,res.album_count,'album_count'
    assert_at_least 10,res.track_count,'track_count'
    assert_at_least 10,res.playlist_count,'playlist_count'
  end

end
