module Rdio
  
  class Api < BaseApi
    
    def initialize(key,secret)
      super key,secret
    end
    
    # Add a friend to the current user.
    def addFriend(user)
      method = 'addFriend'
      type = true
      args = {:user=>user}
      return_object type,method,args
    end
    
    # Add tracks or playlists to the current user's collection.
    def addToCollection(objs)
      method = 'addToCollection'
      type = true
      args = {:keys=>keys(objs)}
      return_object type,method,args
    end
    
    # Add a track to a playlist.
    def addToPlaylist(playlist,tracks)
      method = 'addToPlaylist'
      type = true
      args = {:playlist=>playlist, :tracks=>keys(tracks)}
      return_object type,method,args
    end
    
    # Create a new playlist in the current user's collection.  The new
    # playlist will be returned if the creation is successful, otherwise
    # null will be returned.
    def createPlaylist(name,description,tracks,extras=nil)
      method = 'createPlaylist'
      type = Playlist
      args = {:name=>name,:description=>description,
        :tracks=>keys(tracks)}
      args[:extras] = extras if extras
      return_object type,method,args
    end
    
    # Get information about the currently logged in user.
    def currentUser(extras=nil)
      method = 'currentUser'
      type = User
      args = {}
      args[:extras] = extras if extras
      return_object type,method,args
    end
    
    # Delete a playlist.
    def deletePlaylist(playlist)
      method = 'deletePlaylist'
      type = Boolean
      args = {:playlist=>playlist}
      return_object type,method,args
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
    def get(objs,type=nil)
      if not objs.is_a? Array
        objs = [objs]
      end
      method = 'get'
      cls = type
      args = {:keys=>keys(objs)}
      return_object cls,method,args,true
    end
    
    # Get the activity events for a user, a user's friends, or
    # everyone on Rdio.
    def getActivityStream(user,scope,last_id=nil)
      method = 'getActivityStream'
      type = ActivityStream
      args = {:user=>user,:scope=>scope}
      args[:last_id] = last_id if last_id
      return_object type,method,args
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
    def getAlbumsForArtistInCollection(artist,user=nil)
      method = 'getAlbumsForArtistInCollection'
      type = Album
      args = {:artist=>artist}
      args[:user] = user if user
      return_object type,method,args
    end
    
    # Get all of the albums in the user's collection.
    def getAlbumsInCollection(user=nil,start=nil,count=nil,sort=nil,query=nil)
      method = 'getAlbumsInCollection'
      type = Album
      args = {}
      args[:user] = user if user
      args[:start] = start if start
      args[:count] = count if count
      args[:sort] = sort if sort
      args[:query] = query if query
      return_object type,method,args
    end
    
    # Get all of the artist in a user's collection.
    def getArtistsInCollection(user=nil,start=nil,count=nil,sort=nil,query=nil)
      method = 'getArtistsInCollection'
      type = Artist
      args = {}
      args[:user] = user if user
      args[:start] = start if start
      args[:count] = count if count
      args[:sort] = sort if sort
      args[:query] = query if query
      return_object type,method,args
    end
    
    # Find the most popular artists or albums for a user, their friends
    # or the whole site.
    def getHeavyRotation(user=nil,type=nil,friends=nil,limit=nil)
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
      return_object type,method,args
    end
    
    # Return the object that the supplied Rdio url is a representation
    # of, or null if the url doesn't represent an object.
    def getObjectFromUrl(url,type=nil)
      method = 'getObjectFromUrl'
      type = BaseObj if not type
      args = {:url=>url}
      return_object type,method,args
    end
    
    # Get an playback token. If you are using this for web playback you
    # must supply a domain.
    def getPlaybackToken(domain=nil)
      method = 'getPlaybackToken'
      type = String
      args = {}
      args[:domain] = domain if domain
      return_object type,method,args
    end
      
    # Get the current user's playlists.
    def getPlaylists(extras=nil)
      method = 'getPlaylists'
      type = Playlist
      args = {}
      args[:extras] = extras if extras
      return_object type,method,args
    end
    
    # Return the site-wide most popular items for a given type.
    def getTopCharts(type,start=nil,count=nil,extras=nil)
      method = 'getTopCharts'
      cls = TODO
      case type
      when 'Artist':
          cls = Artist
      when 'Album':
          cls = Album
      when 'Track':
          cls = Track
      when 'Playlist':
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
    def getTracksInCollection(user=nil,start=nil,count=nil,sort=nil,query=nil)
      method = 'getTracksInCollection'
      type = Track
      args = {}
      args[:user] = user if user
      args[:start] = start if start
      args[:count] = count if count
      args[:sort] = sort if sort
      args[:query] = query if query
      return_object type,method,args
    end
    
    # Remove a friend from the current user.
    def removeFriend(user)
      method = 'removeFriend'
      type = Boolean
      args = {:user=>user}
      return_object type,method,args
    end
    
    # Remove tracks or playlists from the current user's collection.
    def removeFromCollection(objs)
      method = 'removeFromCollection'
      type = Boolean
      args = {:keys=>keys(objs)}
      return_object type,method,args
    end
    
    # Remove an item from a playlist by its position in the playlist.
    def removeFromPlaylist(playlist,index,count,tracks)
      method = 'removeFromPlaylist'
      type = TODO
      args = {
        :playlist=>playlist,:index=>index,
        :count=>count,:tracks=>keys(tracks)
      }
      return_object type,method,args
    end
    
    # Search for artists, albums, tracks, users or all kinds of objects.
    def search(query,types=nil,never_or=nil,extras=nil,start=nil,count=nil)
      method = 'search'
      type = TODO
      args = {:query=>query}
      args[:types] = types if types
      args[:never_or] = never_or if never_or
      args[:extras] = extras if extras
      args[:start] = start if start
      args[:count] = count if count
      return_object type,method,args
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
    
  end

end
