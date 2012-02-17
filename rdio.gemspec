# -*- ruby -*-

Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.7'

  s.name              = 'rdio'
  s.version           = '0.0.98'
  s.date              = '2012-02-16'
  s.rubyforge_project = '%NAME'

  s.summary     = "Rdio"
  s.description = "Ruby implementation of rd.io REST api"

  s.authors  = ["Jeffrey Palm"]
  s.email    = 'jeff@jeffpalm.com'
  s.homepage = 'http://github.com/spudtrooper/rdiorb'

  s.require_paths = %w[lib]

  # Dependencies
  s.add_dependency('oauth', '>= 0.3.0')

  # Requirements
  s.requirements << 'launchy gem to use authorized calls'

  s.rdoc_options = ["--charset=UTF-8"]
  s.has_rdoc = false
  s.extra_rdoc_files = %w[README LICENSE]

  # = MANIFEST =
  s.files = %w[
    README
    LICENSE
    lib/rdio.rb
    lib/rdio/api.rb
    lib/rdio/oauth.rb
    lib/rdio/base.rb
    lib/rdio/datatypes.rb
    lib/rdio/types.rb
    lib/rdio/call.rb
  ]
  # = MANIFEST =

  s.test_files = s.files.select { |path| path =~ /^test\/test_.*\.rb/ }
end
