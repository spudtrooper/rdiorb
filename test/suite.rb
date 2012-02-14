$LOAD_PATH << '.'

Dir[File.join File.dirname(__FILE__),'test_*.rb'].each do |file|
  puts
  require file
end
