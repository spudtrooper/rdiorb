module Rdio
  
  # ----------------------------------------------------------------------
  # Provides main API functionality by translating Ruby calls to REST
  # calls to the super class
  # ----------------------------------------------------------------------
  class Api < BaseApi
    
    def initialize(key=nil,secret=nil)
      super key,secret
    end

    # AccessToken[token] -> Api
    #
    # Returns a new instance initialized from the passed in access
    # token
    #
    def self.from_token(token)
      api = Api.new
      api.access_token = token
      return api
    end
    
    # Add a friend to the current user.
    def addFriend(user)
      method = 'addFriend'
      type = true
      args = {:user=>user}
      return_object type,method,args,true
    end
    
    # Add tracks or playlists to the current user's collection.
    def addToCollection(objs)
      method = 'addToCollection'
      type = true
      args = {:keys=>Rdio::keys(objs)}
      return_object type,method,args,true
    end
    
    # Add a track to a playlist.
    def addToPlaylist(playlist,tracks)
      method = 'addToPlaylist'
      type = true
      args = {:playlist=>playlist, :tracks=>Rdio::keys(tracks)}
      return_object type,method,args,true
    end
    
    # Create a new playlist in the current user's collection.  The new
    # playlist will be returned if the creation is successful, otherwise
    # null will be returned.
    def createPlaylist(name,description,tracks,extras=nil)
      method = 'createPlaylist'
      type = Playlist
      args = {:name=>name,:description=>description,
        :tracks=>Rdio::keys(tracks)}
      args[:extras] = extras if extras
      return_object type,method,args,true
    end
    
    # Get information about the currently logged in user.
    def currentUser(extras=nil)
      method = 'currentUser'
      type = User
      args = {}
      args[:extras] = extras if extras
      return_object type,method,args,true
    end
    
    # Delete a playlist.
    def deletePlaylist(playlist)
      method = 'deletePlaylist'
      type = Boolean
      args = {:playlist=>playlist}
      return_object type,method,args,true
    end
    
    # Find a user either by email address or by their username.  Exactly
    # one of email or vanityName must be supplied.
    def findUserByEmail(email)
      method = 'findUser'
      type = User
      args = {:email=>email}
      return_object type,method,args
    end
    
    # Find a user either by email address or by their username.  Exactly
    # one of email or vanityName must be supplied.
    def findUserByVanityName(name)
      method = 'findUser'
      type = User
      args = {:vanityName=>name}
      return_object type,method,args
    end
    
    # Fetch one or more objects from Rdio.
    def get(objs,type=nil,extras=nil)
      if not objs.is_a? Array
        objs = [objs]
      end
      method = 'get'
      cls = type
      args = {:keys=>Rdio::keys(objs)}
      args[:extras] = extras if extras
      json = call method,args
      if Rdio::log_json
        Rdio::log "json: #{json}"
      end
      create_object type,json,true
    end
    
    # Get the activity events for a user, a user's friends, or
    # everyone on Rdio.
    def getActivityStream(user,scope,last_id=nil)
      method = 'getActivityStream'
      type = ActivityStream
      args = {:user=>user,:scope=>scope}
      args[:last_id] = last_id if last_id
      auth = user
      return_object type,method,args,auth
    end
    
    # Return the albums by (or featuring) an artist.
    def getAlbumsForArtist(artist,featuring=nil,extras=nil,start=nil,count=nil)
      method = 'getAlbumsForArtist'
      type = Album
      args = {:artist=>artist}
      args[:featuring] = featuring if featuring
      args[:extras] = extras if extras
      args[:start] = start if start
      args[:count] = count if count
      return_object type,method,args
    end
    
    # Get the albums in the user's collection by a particular artist.
    def getAlbumsForArtistInCollection(artist,user=nil,extras=nil)
      method = 'getAlbumsForArtistInCollection'
      type = Album
      args = {:artist=>artist}
      args[:user] = user if user
      args[:extras] = extras if extras
      auth = !!user
      return_object type,method,args,auth
    end
    
    # Get all of the albums in the user's collection.
    def getAlbumsInCollection(user=nil,start=nil,count=nil,
                              sort=nil,query=nil,extras=nil)
      method = 'getAlbumsInCollection'
      type = Album
      args = {}
      args[:user] = user if user
      args[:start] = start if start
      args[:count] = count if count
      args[:sort] = sort if sort
      args[:query] = query if query
      args[:extras] = extras if extras
      auth = !!user
      return_object type,method,args,auth
    end
    
    # Get all of the artist in a user's collection.
    def getArtistsInCollection(user=nil,start=nil,count=nil,sort=nil,
                               query=nil,extras=nil)
      method = 'getArtistsInCollection'
      type = Artist
      args = {}
      args[:user] = user if user
      args[:start] = start if start
      args[:count] = count if count
      args[:sort] = sort if sort
      args[:query] = query if query
      args[:extras] = extras if extras
      auth = !!user
      return_object type,method,args,auth
    end
    
    # Find the most popular artists or albums for a user, their friends
    # or the whole site.
    def getHeavyRotation(user=nil,type=nil,friends=nil,limit=nil,extras=nil)
      method = 'getHeavyRotation'
      cls = TODO
      if type == 'artist'
        cls = Artist
      elsif type == 'album'
        cls = Album
      end
      args = {}
      args[:user] = user if user
      args[:type] = type if type
      args[:friends] = friends if friends
      args[:limit] = limit if limit
      args[:extras] = extras if extras
      return_object cls,method,args
    end
    
    # Return new albums released across a timeframe.
    def getNewReleases(time=nil,start=nil,count=nil,extras=nil)
      method = 'getNewReleases'
      type = Album
      args = {}
      args[:time] = time if time
      args[:start] = start if start
      args[:count] = count if count
      args[:extras] = extras if extras
      return_object type,method,args
    end
    
    # Return the object that the supplied Rdio short-code is a
    # representation of, or null if the short-code is invalid.
    def getObjectFromShortCode(short_code,type=nil)
      method = 'getObjectFromShortCode'
      type = BaseObj if not type
      args = {:short_code=>short_code}
      return_object type,method,args,true
    end
    
    # Return the object that the supplied Rdio url is a representation
    # of, or null if the url doesn't represent an object.
    def getObjectFromUrl(url,type=nil)
      method = 'getObjectFromUrl'
      type = BaseObj if not type
      args = {:url=>url}
      return_object type,method,args,true
    end
    
    # Get an playback token. If you are using this for web playback you
    # must supply a domain.
    def getPlaybackToken(domain=nil)
      method = 'getPlaybackToken'
      type = String
      args = {}
      args['domain'] = domain if domain
      return_object type,method,args,true
    end
      
    # Get the current user's playlists.
    def getPlaylists(extras=nil)
      method = 'getPlaylists'
      type = Playlist
      args = {}
      args[:extras] = extras if extras
      return_object type,method,args,true
    end
    
    # Return the site-wide most popular items for a given type.
    def getTopCharts(type,start=nil,count=nil,extras=nil)
      method = 'getTopCharts'
      cls = TODO
      case type
      when 'Artist'
        cls = Artist
      when 'Album'
        cls = Album
      when 'Track'
        cls = Track
      when 'Playlist'
        cls = Playlist
      end
      args = {:type=>type}
      return_object cls,method,args
    end
    
    # Which tracks on the given album are in the user's collection.
    def getTracksForAlbumInCollection(album,user=nil,extras=nil)
      method = 'getTracksForAlbumInCollection'
      type = Track
      args = {:album=>album}
      args[:user] = user if user
      args[:extras] = extras if extras
      return_object type,method,args
    end
    
    # Get all of the tracks by this artist.
    def getTracksForArtist(artist,appears_on=nil,start=nil,count=nil,extras=nil)
      method = 'getTracksForArtist'
      type = Track
      args = {:artist=>artist}
      args[:appears_on] = appears_on if appears_on
      args[:start] = start if start
      args[:count] = count if count
      args[:extras] = extras if extras
      return_object type,method,args
    end
    
    # Which tracks from the given artist are in the user's collection.
    def getTracksForArtistInCollection(artist,user=nil,extras=nil)
      method = 'getTracksForArtistInCollection'
      type = Track
      args = {:artist=>artist}
      args[:user] = user if user
      args[:extras] = extras if extras
      return_object type,method,args
    end
    
    # Get all of the tracks in the user's collection.
    def getTracksInCollection(user=nil,start=nil,count=nil,sort=nil,query=nil,extras=nil)
      method = 'getTracksInCollection'
      type = Track
      args = {}
      args[:user] = user if user
      args[:start] = start if start
      args[:count] = count if count
      args[:sort] = sort if sort
      args[:query] = query if query
      args[:extras] = extras if extras
      return_object type,method,args
    end
    
    # Remove a friend from the current user.
    def removeFriend(user)
      method = 'removeFriend'
      type = Boolean
      args = {:user=>user}
      return_object type,method,args,true
    end
    
    # Remove tracks or playlists from the current user's collection.
    def removeFromCollection(objs)
      method = 'removeFromCollection'
      type = Boolean
      args = {:keys=>Rdio::keys(objs)}
      return_object type,method,args
    end
    
    # Remove an item from a playlist by its position in the playlist.
    def removeFromPlaylist(playlist,index,count,tracks)
      method = 'removeFromPlaylist'
      type = TODO
      args = {:playlist=>playlist,:index=>index,
        :count=>count,:tracks=>Rdio::keys(tracks)}
      return_object type,method,args,true
    end

    # Start or stop collaborating on this playlist.
    def setPlaylistCollaborating(playlist,collaborating)
      method = 'setPlaylistCollaborating'
      type = Boolean
      args = {:playlist=>playlist,:collaborating=>collaborating}
      return_object type,method,args,true
    end

    # Start or stop collaborating on this playlist.
    def setPlaylistCollaborationMode(playlist,mode)
      method = 'setPlaylistCollaborationMode'
      type = Boolean
      args = {:playlist=>playlist,:mode=>mode}
      return_object type,method,args,true
    end

    # Saves the given order of tracks in a given playlist. The new
    # order must have the same tracks as the previous order (this
    # method may not be used to add/remove tracks).
    def setPlaylistOrder(playlist,tracks)
      method = 'setPlaylistOrder'
      type = Boolean
      args = {:playlist=>playlist,:tracks=>Rdio::keys(tracks)}
      return_object type,method,args,true
    end

    # Sets the name and description for a playlist.
    def setPlaylistFields(playlist,name,description)
      method = 'setPlaylistFields'
      type = Boolean
      args = {:playlist=>playlist,:name=>name,:description=>description}
      return_object type,method,args,true
    end
    
    # Search for artists, albums, tracks, users or all kinds of objects.
    def search(query,types=nil,never_or=nil,extras=nil,start=nil,count=nil)
      result = search_json query,types,never_or,extras,start,count
      return result if not result
      results = result['results'] || []
      api = self
      #
      # This start out nil, because we need to reference classes in
      # types.rb and this gets loaded after this file.  There's
      # probably a better way to do this.
      #
      if not @@types2classes
        @@types2classes = {
          'r' => Artist,
          'a' => Album,
          's' => User,
          't' => Track,
          'p' => Playlist
        }
      end
      results.map {|o| @@types2classes[o['type']].new(api).fill o}
    end

    def counts(query,types=nil,never_or=nil,extras=nil,start=nil,count=nil)
      obj = search_json query,types,never_or,extras,start,count
      return JSONObj.new obj
    end
    
    # Match the supplied prefix against artists, albums, tracks and
    # people in the Rdio system.  Return the first ten matches.
    def searchSuggestions(query,extras)
      method = 'searchSuggestions'
      type = TODO
      args = {:query=>query}
      args[:extras] = extras if extras
      return_object type,method,args
    end

    private

    # Initialize this after types.rb has been loaded (this stinks!)
    @@types2classes = nil

    # Search for artists, albums, tracks, users or all kinds of objects.
    def search_json(query,types=nil,never_or=nil,extras=nil,start=nil,count=nil)
      method = 'search'
      type = TODO
      if not types
        types = 'Artist,Album,Track,Playlist,User'
      end
      args = {:query=>query}
      args[:types] = types if types
      args[:never_or] = never_or if never_or
      args[:extras] = extras if extras
      args[:start] = start if start
      args[:count] = count if count
      
      json = call method,args
      if Rdio::log_json
        Rdio::log json
      end
      return unwrap_json json
    end
    
  end

end
