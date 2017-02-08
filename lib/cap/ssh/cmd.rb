require "cap/ssh/cmd/version"
if defined?(Capistrano::VERSION)
  case Capistrano::VERSION
  when /^2/
    require(File.join(File.dirname(__FILE__),'cmd','2.rake'))
  when /^3/
    require(File.join(File.dirname(__FILE__),'cmd','2.rake'))
  else
    raise(NotImplementedError)
  end
end