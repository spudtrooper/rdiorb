require File.dirname(__FILE__) + '/common'
include Rdio

class TestArtist < RdioTestCase

  def test_get
    artist = Artist.get 'r87304'
    assert_equal Artist,artist.class
    assert_equal 'Bad Religion',artist.name
  end

  def test_from_url
    artist = Artist.from_url 'http://www.rdio.com/#/artist/Bad_Religion/'
    assert_equal Artist,artist.class
    assert_equal 'Bad Religion',artist.name
  end

  def test_search
    artists = Artist.search 'Bad Religion'
    artist = artists.shift
    assert_equal Artist,artist.class
    assert_equal 'Bad Religion',artist.name
  end

end
