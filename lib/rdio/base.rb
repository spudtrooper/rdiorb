require 'rubygems'
require 'json'

# Make sure objects return 'self' by default to 'to_k', then we can
# override this for subsequent types -- like Artist, Track, etc --
# that need to use their key for this value
class Object
  def to_k
    return self
  end
end

# When putting classes into arguments to BaseApi.call we want to use a
# classes simple name for the argument value
class Class
  def to_k
    name.gsub /.*\:\:/,''
  end
end

module Rdio

  class << self

    # hash -> hash
    #
    # Uses the value of 'to_k' for all the iput hash values in the
    # result hash. This is used to make sure that the arguments passed
    # to create urls use keys for the values of objects like Artist,
    # Track, etc.  Also, we use the simple name of classes.
    #
    def convert_args(args)
      return nil if not args
      res = {}
      args.each do |k,v|
        if v.is_a? Array
          v = keys v
        else
          v = v.to_k
        end
        res[k] = v
      end
      return res
    end

    # string -> string
    #
    # Converts camel-case string to underscore-delimited one.
    #
    def camel2underscores(s)
      return s if not s
      return s if s == ''
      def decapitilize(s)
        s[0,1].downcase + s[1,s.length-1].to_s
      end
      s = decapitilize s 
      while s.match /([A-Z]+)/
        s = s.gsub /#{$1}/,'_'+ decapitilize($1)
      end
      s
    end

    # Adds 'str' to the array or string 'arr'
    def add_to_array(arr,str)
      if arr == nil
        return [str.to_s]
      end
      if arr == ''
        return [str.to_s]
      end
      if arr.is_a? Array
        return arr + [str.to_s]
      end
      return arr.to_s + ',' + str.to_s
    end
    
    # array -> string
    #
    # Creates a ','-separated string of the value of 'to_k' from all the
    # values in 'objs'.  We also remove the nils from the input array.
    #
    def keys(objs)
      (not objs) ? '' : objs.compact.map {|x| x.to_k}.join(',')
    end

    # object -> value
    #
    # Converts v which is probably a string, to a primitive value, so we
    # can have primitives other than strings as attributes of BaseObjs.
    #
    def to_o(v)
      if v == nil
        return nil
      end
      s = v.to_s
      if not s
        return nil
      end
      if s == 'nil'
        return nil
      end
      if s =~ /^\d+$/
        return s.to_i
      end
      if s =~ /^\d+\.?\d*$/
        return s.to_f
      end
      if s == 'true'
        return true
      end
      if s == 'false'
        return false
      end
      if s =~ /^\[.*\]$/
        s = s.gsub /^\[/,''
        s = s.gsub /\]$/,''
        return s.split(',').map {|x| Rdio::to_o x}
      end
      return s
    end
    
  end

  class << self
    #
    # Override this to declare how certain attributes are constructed.
    # This is done at the end of types.rb.
    #
    attr_accessor :symbols_to_types

  end
  self.symbols_to_types = {}

  # ----------------------------------------------------------------------
  # Base class for remote objects.  They contain an api instance, and
  # also have a fill method that will set the values to the
  # appropriate values
  # ----------------------------------------------------------------------
  class ApiObj
    attr_reader :api
    
    def initialize(api)
      @api = api
    end

    def fill(x)
      return self if not x
      syms_to_types = Rdio::symbols_to_types || {}
      x.each do |k,v|
        sym = Rdio::camel2underscores(k).to_sym
        #
        # If we have an actual type for this symbol, then use that
        # type to construct this value.  Otherwise, it's just a
        # primitive type
        #
        type = syms_to_types[sym]
        if Rdio::log_symbols
          Rdio::log "#{self.class}.#{sym} => #{type}"
        end
        if type
          #
          # Allow simple types that are used for arrays
          #
          if v.is_a? Array
            o = v.map {|x| type.new(api).fill x}
          else
            o = type.new api
            o.fill v
          end
        else
          o = Rdio::to_o v
        end
        begin
          sym_eq = (Rdio::camel2underscores(k)+'=').to_sym
          self.send sym_eq,o
        rescue Exception => e
          Rdio::logger.warn "Couldn't find symbol: " +
            "#{sym} => #{o} for type: #{self.class}"
        end
      end
      self
    end

  end

  # ----------------------------------------------------------------------
  # An Object that is based on json with simple types
  # ----------------------------------------------------------------------
  class JSONObj

    attr_reader :json

    def initialize(json)
      @json = json
    end

    def method_missing(method,args={})
      meth = method.to_s
      res = @json[meth]
      #
      # Maybe this should be a number
      #
      if meth =~ /_count$/ or meth =~ /^num_/
        begin
          return res.to_i
        rescue Exception => e
          STDERR.puts "#{meth} (err) #{e}"
        end
      end
      return res
    end
  end
  
  # ----------------------------------------------------------------------
  # An ApiObj with a 'key'
  # ----------------------------------------------------------------------
  class BaseObj < ApiObj

    attr_accessor :key

    def initialize(api)
      super api
    end

    # Compares only by key
    def eql?(that)  
      self.class.equal? that.class and self.key.equal? that.key
    end

    def to_k
      key
    end

  end

  # ----------------------------------------------------------------------
  # Basis for making web-service calls and constructing the values.
  # Subclasses should declare the api by calling 'call',
  # 'return_object', and 'create_object'
  # ----------------------------------------------------------------------
  class BaseApi

    PATH = '/1/'

    attr_reader :oauth

    def initialize(key,secret)
      @oauth = RdioOAuth.new key,secret
      @access_token_auth = nil
      @access_token_no_auth = nil
    end

    # (string -> string) -> (string -> string)
    #
    # Sets the function that will return a pin given an authorization
    # url for the contained RdioOAuth instance
    #
    def get_pin=(get_pin)
      @oauth.get_pin = get_pin
    end

    def get_pin
      @oauth.get_pin
    end

    def call(method,args,requires_auth=false)
      #
      # Convert object with keys just to use their keys
      #
      args = Rdio::convert_args args
      if Rdio::log_methods
        Rdio::log "Called method: #{method}(#{args}) : auth=#{requires_auth}"
      end
      new_args = {}
      new_args['method'] = method
      args.each do |k,v|
        new_args[k] = v.to_k.to_s
      end
      url = PATH
      if Rdio::log_posts
        Rdio::log "Post to url=#{url} method=#{method} args=#{args}"
      end
      resp,data = access_token(requires_auth).post url,new_args
      return data
    end

    def return_object(type,method,args,requires_auth=false)
      json = call method,args,requires_auth
      if Rdio::log_json
        Rdio::log json
      end
      create_object type,json
    end

    private

    def fill_obj(type,x)
      res = type.new self
      res.fill x
      return res
    end

    def create_object(type,json_str,keys_to_objects=false)
      begin
        _create_object(type,json_str,keys_to_objects)
      rescue Exception => e
        STDERR.puts "create_json (err): #{e}"
        STDERR.puts "create_json (str): #{json_str}"
        raise e
      end
    end

    def unwrap_json(json_str)
      obj = JSON.parse json_str
      status = obj['status']
      if status == 'error'
        raise Exception.new obj['message']
      end
      if status == 'ok'
        return obj['result']
      end
      raise Exception.new status
    end
    
    def _create_object(type,json_str,keys_to_objects=false)
      if type == true
        return true
      end
      if type == false
        return false
      end
      result = unwrap_json(json_str)
      if type == Boolean or type == String or 
          type == Fixnum or type == Float
        return false if not result
        return Rdio::to_o result
      end
      #
      # A mild hack, but for get the result is a hash of keys to
      # objects, in this case return an array of those objects
      #
      if keys_to_objects
        result = result.values
      end
      #
      # This could be an array (TODO: could not be general enough)
      #
      if result.is_a? Array
        res = result.map {|x| fill_obj type,x}
      else 
        res = fill_obj type,result
      end
      return res
    end

    def access_token(requires_auth)
      if requires_auth
        if not @access_token_auth
          @access_token_auth = @oauth.access_token requires_auth
        end
        res = @access_token_auth
      else
        if not @access_token_no_auth
          @access_token_no_auth = @oauth.access_token requires_auth
        end
        res = @access_token_no_auth
      end
      res
    end

  end

end
