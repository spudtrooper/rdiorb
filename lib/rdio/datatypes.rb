module Rdio

  class ArtistData < BaseObj
    def initialize(api)
      super api
    end

    # the name of the artist
    attr_accessor :name

    # the object type, always "r"
    attr_accessor :type

    # the URL of the artist on the Rdio web site
    attr_accessor :url

    # the number of tracks that the artist has on Rdio
    attr_accessor :length

    # an image for the artist
    attr_accessor :icon

    # an image for the artist, partial URL
    attr_accessor :base_icon

    # is an Rdio Station available for the artist?
    attr_accessor :has_radio

    # a short URL for the artist page
    attr_accessor :short_url

    # the number of albums that the artist has on Rdio
    attr_accessor :album_count

  end

  class AlbumData < BaseObj
    def initialize(api)
      super api
    end

    # the name of the album
    attr_accessor :name

    # the type of the object, always "a"
    attr_accessor :type

    # the URL to the cover art for the album
    attr_accessor :icon

    # the URL to the cover art for the album
    attr_accessor :base_icon

    # the URL of the album on the Rdio site
    attr_accessor :url

    # the name of the artist that released the album
    attr_accessor :artist

    # the URL of the artist that released the album on the Rdio site
    attr_accessor :artist_url

    # is the album explicit?
    attr_accessor :is_explicit

    # is the album clean?
    attr_accessor :is_clean

    # number of tracks on the album
    attr_accessor :length

    # the key of the artist that released the album
    attr_accessor :artist_key

    # the keys of the tracks on the album
    attr_accessor :track_keys

    # the price of the album in US cents
    attr_accessor :price

    # the album can be streamed
    attr_accessor :can_stream

    # the album can be previewed
    attr_accessor :can_sample

    # the album can be sync to mobile devices
    attr_accessor :can_tether

    # a short URL for the album
    attr_accessor :short_url

    # the URL of a SWF to embed the album
    attr_accessor :embed_url

    # the release date of the album, human readable
    attr_accessor :display_date

    # the release date of the album
    attr_accessor :release_date

    # the duration of the album in seconds
    attr_accessor :duration

    # the release date of the album in ISO format
    attr_accessor :release_date_iso

  end

  class TrackData < BaseObj
    def initialize(api)
      super api
    end

    # the secondary id
    attr_accessor :secondary_id

    # the name of the track
    attr_accessor :name

    # the name of the artist who performed the track
    attr_accessor :artist

    # the name of the album that the track appears on
    attr_accessor :album

    # the key of the album that the track appears on
    attr_accessor :album_key

    # the URL of the album that the track appears on, on the Rdio web site
    attr_accessor :album_url

    # the key of the track's artist
    attr_accessor :artist_key

    # the URL of the track's artist on the Rdio web site
    attr_accessor :artist_url

    # the object type, always "t"
    attr_accessor :type

    # the number of tracks in the track, ie: 1
    attr_accessor :length

    # the duration of the track in seconds
    attr_accessor :duration

    # is the track explicit?
    attr_accessor :is_explicit

    # is the track clean?
    attr_accessor :is_clean

    # the URL of the track on the Rdio web site
    attr_accessor :url

    # the URL of the album-art for the track
    attr_accessor :base_icon

    # the name of the artist whose album the track appears on
    attr_accessor :album_artist

    # the key of the artist whose album the track appears on
    attr_accessor :album_artist_key

    # the track can be downloaded
    attr_accessor :can_download

    # the track can only be downloaded as part of an album download
    attr_accessor :can_download_album_only

    # the track can be streamed
    attr_accessor :can_stream

    # the track can be synced to mobile devices
    attr_accessor :can_tether

    # the track can be previewed
    attr_accessor :can_sample

    # the price of the track in US cents
    attr_accessor :price

    # a short URL for the track
    attr_accessor :short_url

    # the URL of a SWF to embed the track
    attr_accessor :embed_url

    # the partial URL of the album-art for the track
    attr_accessor :icon

    # the number of times this track has been played
    attr_accessor :play_count

  end

  class PlaylistData < BaseObj
    def initialize(api)
      super api
    end

    # the name of the playlist
    attr_accessor :name

    # the number of tracks in the playlist
    attr_accessor :length

    # the object type, always "p"
    attr_accessor :type

    # the URL of the playlist on the Rdio site
    attr_accessor :url

    # the URL of an icon for the playlist
    attr_accessor :icon

    # the URL of an icon for the playlist
    attr_accessor :base_icon

    # the name of the user who created the playlist
    attr_accessor :owner

    # the URL on the Rdio site of the user who created the playlist
    attr_accessor :owner_url

    # the key of the user who created the playlist
    attr_accessor :owner_key

    # the icon of the user who created the playlist
    attr_accessor :owner_icon

    # when the playlist was last modified
    attr_accessor :last_updated

    # a short URL for the playlist
    attr_accessor :short_url

    # the URL of a SWF to embed the playlist
    attr_accessor :embed_url

  end

  class UserData < BaseObj
    def initialize(api)
      super api
    end

    # the first name of the user
    attr_accessor :first_name

    # the last name of the user
    attr_accessor :last_name

    # the URL of an image of the user
    attr_accessor :icon

    # the URL of an image of the user
    attr_accessor :base_icon

    # the library version of the user, used to determine if a user's collection has changed
    attr_accessor :library_version

    # the URL of the user on the Rdio site
    attr_accessor :url

    # "m" or "f"
    attr_accessor :gender

    # the object type, always "s"
    attr_accessor :type

    # the user's vanity name
    attr_accessor :username

    # the last song the user has played
    attr_accessor :last_song_played

    # how to display the user's name
    attr_accessor :display_name

    # the number of tracks in the user's collection
    attr_accessor :track_count

    # when the last played song was played
    attr_accessor :last_song_play_time

  end

end
