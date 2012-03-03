require File.dirname(__FILE__) + '/common'
include Rdio

class TestAlbum < RdioTestCase

  def test_artist
    album = Album.get 'a446068'
    artist = album.artist
    assert_equal Artist,artist.class
    assert_equal 'Built To Spill',artist.name
  end

  def test_artist_name
    album = Album.get 'a446068'
    artist_name = album.artist_name
    assert_equal String,artist_name.class
    assert_equal 'Built To Spill',artist_name
  end

  def test_tracks
    album = Album.get 'a446068','tracks'
    tracks = album.tracks
    assert_equal 10,tracks.length
    tracks.each do |t|
      assert_equal Track,t.class
    end
  end

  def test_explicit
    album = Album.get 'a446068'
    res = album.explicit?
    assert_equal false,res
    res = album.is_explicit
    assert_equal false,res
  end

  def test_clean
    album = Album.get 'a446068'
    res = album.clean?
    assert_equal false,res
    res = album.is_clean
    assert_equal false,res
  end

  def test_compilation_false
    album = Album.get 'a446068','isCompilation'
    res = album.compilation?
    assert_equal false,res
    res = album.is_compilation
    assert_equal false,res
  end

  def test_compilation_true
    album = Album.get 'a244657','isCompilation'
    res = album.compilation?
    assert_equal true,res
    res = album.is_compilation
    assert_equal true,res
  end

  def test_big_icon
    album = Album.get 't2979981','bigIcon'
    assert album.big_icon =~ /.*\/album\/1\/b\/b\/000000000003bbb1\/square-600\.jpg/
  end

end
