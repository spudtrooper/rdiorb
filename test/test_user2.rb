require File.dirname(__FILE__) + '/common'
require File.dirname(__FILE__) + '/../lib/rdio'
include Rdio

class TestUser2 < Test::Unit::TestCase

  user = nil

  def setup
    if not @user
      @user = User.find_by_email 'jeff@jeffpalm.com'
    end
  end

  def test_albums_in_collection
    albums = @user.albums_in_collection
    assert_length_at_least 20,albums,'albums_in_collection'
    albums = @user.albums_in_collection 0,10
    assert_equal 10,albums.length
  end

  def test_albums_for_artist_in_collection
    artist = Artist.get 'r85592'
    albums = @user.albums_for_artist_in_collection artist
    assert_length_at_least 7,albums,'albums'
  end

  def test_albums_in_collection
    user = User.current
    arr = user.albums_in_collection
    assert_length_at_least 100,arr,'album'
    arr = user.albums_in_collection 0,10
    assert_equal 10,arr.length
  end

  def test_artists_in_collection
    user = User.current
    arr = user.artists_in_collection
    assert_length_at_least 100,arr,'album'
    arr = user.artists_in_collection 0,10
    assert_equal 10,arr.length
  end

  def test_tracks_in_collection
    user = User.current
    arr = user.tracks_in_collection
    assert_length_at_least 100,arr,'track'
    arr = user.tracks_in_collection 0,10
    assert_equal 10,arr.length
  end

  def test_albums_for_artist_in_collection
    user = User.current
    artist = Artist.get 'rl65214|208750'
    albums = user.albums_for_artist_in_collection artist
    assert_not_nil albums
    assert_equal 1,albums.length
    album = albums[0]
    assert_equal 'Badmotorfinger',album.name
  end

  def test_tracks_for_artist_in_collection
    user = User.current
    artist = Artist.get 'rl65214|208750'
    tracks = user.tracks_for_artist_in_collection artist
    assert_not_nil tracks
    name = 'Face Pollution'
    found = false
    tracks.each do |t|
      if t.name == name
        found = true
        break
      end
    end
    if not found
      assert_fail "Couldn't find #{name}"
    end
  end

  def test_tracks_for_album_in_collection
    user = User.current
    album = Album.get 'a256779'
    tracks = user.tracks_for_album_in_collection album
    assert_not_nil tracks
    name = 'Face Pollution'
    found = false
    tracks.each do |t|
      if t.name == name
        found = true
        break
      end
    end
    if not found
      assert_fail "Couldn't find #{name}"
    end
  end

  def test_activity_stream
    user = User.current
    as = user.activity_stream
    assert_length_at_least 10,as.updates,'update'
    assert_not_nil as.last_id
    assert_equal user.key,as.user.key
  end

  
end
