module Rdio

  class Call

    def real_main(argv)

      # Check the command line for the key,secret,etc...
      args = []
      while true
        arg = argv.shift
        break if not arg
        case arg
        when '--consumer-key'
          key = argv.shift
        when '-h','--help'
          print_help
          return 0
        when '--consumer-secret'
          secret = argv.shift
        when '--authenticate'
          authenticate = true
        when '-i','--indent'
          indent = true
        else
          args << arg
        end
      end

      # Look in the environment if not key or consumer token were given on
      # the command line
      key = ENV['RDIO_KEY'] if not key
      secret = ENV['RDIO_SECRET'] if not secret

      if not key
        STDERR.puts 'consumer key required'
        return 1
      end

      if not secret
        STDERR.puts 'consumer secret required'
        return 1
      end

      if args.length < 1
        STDERR.puts 'method name required'
        return 1
      end

      base = Rdio::BaseApi.new key,secret
      method = args.shift
      rdio_args = {}
      args.each do |str|
        parts = str.split /\=/
        key = parts[0]
        val = parts.length == 1 ? true : parts[1]
        rdio_args[key] = val
      end

      res = base.call method,rdio_args,authenticate
      if indent
        begin
          require 'rubygems'
          require 'json'
          json = JSON.parse res
          return JSON.pretty_generate json
        rescue Exception => e
          STDERR.puts e
          STDERR.puts 'You must install the json gem to use the indent \'feature\''
          return res
        end
      else
        return res
      end

    end

    def main(args)
      res = real_main args
      return res if res.is_a? Fixnum
      puts res
      return 0
    end

    private

    def print_help
      STDERR.puts <<HERE
Usage: #{File.basename $0} options? method [key=val]?
where options include
  --consumer-key str       Use the key for authentication
  --consumer-secret str    Use the secret for authentication
  --authentication         Use two-legged authentication
  --indent || -i           Indent the output
  --help || -h             Print this message
and
 - method is the name of the REST method to call
 - key=value are argument pairs to pass
HERE
    end
  end

end
