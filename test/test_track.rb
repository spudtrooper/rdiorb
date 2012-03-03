require File.dirname(__FILE__) + '/common'
include Rdio

class TestTrack < RdioTestCase

  track = nil
  
  def setup
    if not @track
      @track = Track.get 't5483181'
    end
  end

  def test_album
    album = @track.album
    assert_equal Album,album.class
    assert_equal 'a446068',album.key
  end

  def test_artist
    artist = @track.artist
    assert_equal Artist,artist.class
    assert_equal 'r85592',artist.key
  end

  def test_album_artist
    artist = @track.album_artist
    assert_equal Artist,artist.class
    assert_equal 'r85592',artist.key
  end
  def test_album_name
    album = @track.album_name
    assert_equal String,album.class
    assert_equal 'Ultimate Alternative Wavers',album
  end

  def test_artist_name
    artist = @track.artist_name
    assert_equal String,artist.class
    assert_equal 'Built To Spill',artist
  end

  def test_album_artist_name
    artist = @track.album_artist_name
    assert_equal String,artist.class
    assert_equal 'Built To Spill',artist
  end

  def test_on_compilation_false
    track = Track.get 't5483214','isOnCompilation'
    res = track.on_compilation?
    assert_equal false,res
    res = track.is_on_compilation
    assert_equal false,res
  end

  def test_on_compilation_true
    track = Track.get 't2979981','isOnCompilation'
    res = track.on_compilation?
    assert_equal true,res
    res = track.is_on_compilation
    assert_equal true,res
  end

  def test_big_icon
    track = Track.get 't2979981','bigIcon'
    assert track.big_icon =~ /.*\/album\/1\/b\/b\/000000000003bbb1\/square-600\.jpg/
  end

end
