require File.dirname(__FILE__) + '/common'
include Rdio

class TestSearch < RdioTestCase

  def test_search
    res = Search.counts 'Kanye West'
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

  def test_search_artist2
    name = 'Soundgarden'
    res = Artist.search name
    assert_at_least 1,res.length,'length'
    found = false
    res.each do |o|
      assert_equal Artist,o.class
      found = true if name == o.name
    end
    assert_equal true,found
  end

  def test_search_album
    res = Album.search 'The'
    assert_at_least 10,res.length,'length'
    res.each do |o|
      assert_equal Album,o.class
    end
  end

  def test_search_artist2
    name = 'Badmotorfinger'
    res = Album.search name
    assert_at_least 1,res.length,'length'
    found = false
    res.each do |o|
      assert_equal Album,o.class
      found = true if name == o.name
    end
    assert_equal true,found
  end

  def test_search_track
    res = Track.search 'The'
    assert_at_least 10,res.length,'length'
    res.each do |o|
      assert_equal Track,o.class
    end
  end

  def test_search_artist2
    name = 'Rusty'
    res = Track.search name
    assert_at_least 1,res.length,'length'
    found = false
    res.each do |o|
      assert_equal Track,o.class
      found = true if o.name =~ /#{name}/
    end
    assert_equal true,found
  end

  def test_search_user
    res = User.search 'The'
    assert_at_least 10,res.length,'length'
    res.each do |o|
      assert_equal User,o.class
    end
  end

  def test_search_playlist
    res = Playlist.search 'The'
    assert_at_least 10,res.length,'length'
    res.each do |o|
      assert_equal Playlist,o.class
    end
  end

  def test_search_generic
    res = Search.search 'cat'
    assert_at_least 10,res.length,'length'
  end
  
end
