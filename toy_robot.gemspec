# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "toy_robot/version"

Gem::Specification.new do |spec|
  spec.name          = "toy_robot"
  spec.version       = ToyRobot::VERSION
  spec.authors       = ["Ilya Manin"]
  spec.email         = ["bkmzvf@gmail.com"]

  spec.summary       = %q{The application is a simulation of a toy robot moving
                          on a square tabletop.}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "bin"
  spec.executables   = ["toy_robot"]
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.4.1'

  spec.add_development_dependency "bundler",                    "~> 1.15"
  spec.add_development_dependency "codeclimate-test-reporter",  "~> 1.0.0"
  spec.add_development_dependency "rake",                       "~> 11.0"
  spec.add_development_dependency "rspec",                      "~> 3.6"
  spec.add_development_dependency "simplecov",                  "~> 0.12"
end
