# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cap/ssh/cmd/version'

Gem::Specification.new do |spec|

  spec.name          = "cap-ssh-cmd"
  spec.version       = Cap::Ssh::Cmd::VERSION
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]

  spec.summary       = %q{Simple tool to use cap command to open ssh connection to a given server}
  spec.description   = %q{Simple tool to use cap command to open ssh connection to a given server}
  spec.homepage      = "https://github.com/adamluzsi/cap-ssh-cmd.rb"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

end
