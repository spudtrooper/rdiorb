Dir[File.join File.dirname(__FILE__),'test_*.rb'].each do |file|
  require File.expand_path file
end
