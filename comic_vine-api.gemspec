# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'comic_vine/api/version'

Gem::Specification.new do |spec|
  spec.name          = "comic_vine-api"
  spec.version       = ComicVine::Api::VERSION
  spec.authors       = ["Krzysztof Wawer"]
  spec.email         = ["krzysztof.wawer@gmail.com"]

  spec.summary       = %q{Interface to ComicVine API}
  spec.description   = %q{Interface to ComicVine API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end
