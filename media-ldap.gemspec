$:.unshift File.expand_path("../lib", __FILE__)
require "media/ldap/version"

Gem::Specification.new do |gem|
  gem.name        = "media-ldap"
  gem.version     = Media::LDAP::VERSION
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = ["Jamie Hodge"]
  gem.email       = ["jamieh@hum.ku.dk"]
  gem.homepage    = ""
  gem.summary     = %q{}
  gem.description = gem.summary

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.servicename(f) }
  gem.require_paths = ["lib"]

  gem.add_dependency "connection_pool"
  gem.add_dependency "net-ldap"
end
