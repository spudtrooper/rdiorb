require File.dirname(__FILE__) + '/common'
include Rdio

class TestJohan < RdioTestCase

  def test_johan
    r_tracks = [Track.get 't2979981']
    if (!r_tracks.empty?)
      pl = Rdio::Playlist.create("Playlistify","Description...", r_tracks)
      #
      # This still isn't totally fixed because we get an owner with
      # just a string, which doesn't help
      #
      assert pl.owner
      pl.delete
    end
  end

end
