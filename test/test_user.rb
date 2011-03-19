require File.dirname(__FILE__) + '/common'
require File.dirname(__FILE__) + '/../lib/rdio'
include Rdio

class TestUser < Test::Unit::TestCase

  def test_find_by_email
    email = 'jeff@jeffpalm.com'
    user = User.find_by_email email
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_find_by_vanity_name
    name = 'spudtrooper'
    user = User.find_by_vanity_name name
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_current
    user = User.current
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_get
    user = User.get 's208750'
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_all
    users = User.all 's208750'
    assert_not_nil users
    assert_equal 1,users.length
    user = users[0]
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_all2
    users = User.all ['s208750']
    assert_not_nil users
    assert_equal 1,users.length
    user = users[0]
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_albums_in_collection
    user = User.current
    arr = user.albums_in_collection
    assert_length_at_least 100,arr,'album'
  end

  def test_artists_in_collection
    user = User.current
    arr = user.artists_in_collection
    assert_length_at_least 100,arr,'album'
  end

  def test_tracks_in_collection
    user = User.current
    arr = user.tracks_in_collection
    assert_length_at_least 100,arr,'track'
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

  def test_add_friend
    user = User.current
    assert_equal true,User.add_friend(user)
  end

  def test_add_friend2
    that = User.find_by_email 'tim.julien@gmail.com'
    assert_equal true,User.add_friend(that)
  end

  def test_add_and_remove_friend
    that = User.find_by_email 'tim.julien@gmail.com'
    User.add_friend that
    User.remove_friend that
    User.remove_friend that
    User.add_friend that
  end
  
end
