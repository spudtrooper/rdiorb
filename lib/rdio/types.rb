module Rdio

  # Dummy class so we can create booleans from strings
  class Boolean
    
  end

  # Dummy class so we can set the type variable in API methods to TODO
  class TODO

  end

  class Artist < ArtistData
    def initialize(api)
      super api
    end
  end

  class Album < AlbumData
    def initialize(api)
      super api
    end
  end

  class Track < TrackData
    def initialize(api)
      super api
    end
  end

  class Playlist < PlaylistData
    def initialize(api)
      super api
    end
  end

  class User < UserData
    def initialize(api)
      super api
    end
  end

end
