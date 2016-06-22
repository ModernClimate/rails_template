# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "rails_template"
  spec.version       = "1.0.0"
  spec.authors       = ["Jason Bucki", "Tamara Temple"]
  spec.email         = ["jason@ackmanndickenson.com", "tamouse@gmail.com"]

  spec.summary       = "New Rails Project Generator"
  spec.description   = "New Rails Project Generator"
  spec.homepage      = "https://github.com/ackmanndickeson/rails_template"
  spec.license       = "none"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "pry"
end
