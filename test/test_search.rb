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

  def test_search_artist
    res = Artist.search 'Kanye West'
    assert_at_least 10,res.length,'length'
    res.each do |o|
      assert_equal Artist,o.class
    end
  end

  def test_search_album
    res = Album.search 'The'
    assert_at_least 10,res.length,'length'
    res.each do |o|
      assert_equal Album,o.class
    end
  end

  def test_search_track
    res = Track.search 'The'
    assert_at_least 10,res.length,'length'
    res.each do |o|
      assert_equal Track,o.class
    end
  end

  def test_search_user
    res = User.search 'The'
    assert_at_least 10,res.length,'length'
    res.each do |o|
      assert_equal User,o.class
    end
  end

end
