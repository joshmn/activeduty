$:.push File.expand_path("lib", __dir__)

require "active_duty/version"

Gem::Specification.new do |s|
  s.name        = "active_duty"
  s.version     = ActiveDuty::VERSION
  s.summary     = "Service objects."
  s.description = "Service objects."

  s.required_ruby_version = ">= 2.5.0"

  s.license = "MIT"

  s.author   = "Josh Brody"
  s.email    = "josh@josh.mn"
  s.homepage = "https://josh.mn"

  s.files        = Dir["CHANGELOG.md", "MIT-LICENSE", "README.md", "lib/**/*"]
  s.require_path = "lib"

  s.add_dependency "activesupport"
  s.add_dependency "activemodel"
  s.add_development_dependency "pry"
end
