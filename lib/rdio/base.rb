require 'rubygems'
require 'json'

module Rdio

  # string -> string
  #
  # Converts camel-case string to underscore-delimited one.
  #
  def camel2underscores(s)
    while s.match /([A-Z]+)/
      s = s.gsub /#{$1}/,'_'+$1.downcase
    end
    s
  end

  # object -> value
  #
  # Converts v which is probably a string, to a primitive value, so we
  # can have primitives other than strings as attributes of BaseObjs.
  #
  def to_o(v)
    if not v
      return nil
    end
    s = v.to_s
    if not s
      return nil
    end
    if s == 'nil'
      return nil
    end
    if s =~ /^\d+/
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
      return s.split(',').map {|x| to_o x}
    end
    return s
  end

  # Override this to declare how certain attributes are constructed, e.g:
  #
  #    Rdio::symbols_to_types[self] = {
  #      :user => User,
  #      :updates => Update
  #    }
  #
  # This (found in the ActivityStream class) instructs us to create
  # the json object of the 'user' as a User object, and the 'updates'
  # as an Update object.  In fact, 'updates' is an array, and this if
  # fine.
  #
  class << self
    attr_accessor :symbols_to_types
  end
  self.symbols_to_types = {}

  class ApiObj
    attr_reader :api
    
    def initialize(api)
      @api = api
    end

    def fill(x)
      syms_to_types = Rdio::symbols_to_types[self.class] || {}
      x.each do |k,v|
        sym = camel2underscores(k).to_sym
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
            o = v.map do |x|
              obj = type.new api
              obj.fill x
              obj
            end
          else
            o = type.new api
            o.fill v
          end
        else
          o = to_o v
        end
        begin
          sym_eq = (camel2underscores(k)+'=').to_sym
          self.send sym_eq,o
        rescue Exception => e
          STDERR.puts "Couldn't find symbol: " +
            "#{sym} => #{o} for type: #{self.class}"
        end
      end
    end

  end

  class BaseObj < ApiObj

    attr_accessor :key

    def initialize(api)
      super api
    end

  end

  class BaseApi

    def initialize(key,secret)
      @oauth = RdioOAuth.new key,secret
      @access_token = nil
    end

    def call(method,args)
      if Rdio::log_methods
        Rdio::log "Called method: #{method}"
      end
      new_args = {}
      new_args['method'] = method
      args.each do |k,v|
        new_args[k] = BaseApi.key(v).to_s
      end
      url = 'http://api.rdio.com/1/'
      resp,data = access_token.post url,new_args
      return data
    end

    def return_object(type,method,args,keys_to_objects=false)
      json = call method,args
      if Rdio::log_json
        Rdio::log json
      end
      create_object type,json,keys_to_objects
    end

    def keys(objs)
      objs.map {|x| BaseApi.key x}
    end

    private

    def self.key(v)
      begin
        return v.key
      rescue
      end
      return v
    end

    def fill_obj(type,x)
      res = type.new self
      res.fill x
      return res
    end

    def create_object(type,json,keys_to_objects=false)
      begin
        _create_object(type,json,keys_to_objects)
      rescue Exception => e
        puts json
        raise e
      end
    end
    
    def _create_object(type,json,keys_to_objects=false)
      obj = JSON.parse json
      status = obj['status']
      if status == 'ok'
        result = obj['result']
        if type == true
          return true
        end
        if type == false
          return false
        end
        if type == Boolean or type == String or 
            type == Fixnum or type == Float
          return to_o res
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
      if status == 'error'
        raise Exception.new obj['message']
      end
      raise Exception.new status
    end

    def access_token
      if not @access_token
        @access_token = @oauth.access_token
      end
      @access_token
    end

  end

end
