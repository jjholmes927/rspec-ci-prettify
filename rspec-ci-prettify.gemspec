# frozen_string_literal: true

require_relative 'lib/rspec/ci/prettify/version'

Gem::Specification.new do |spec|
  spec.name = 'rspec-ci-prettify'
  spec.version = RSpec::Ci::Prettify::VERSION
  spec.authors = ['jjholmes927']
  spec.email = ['jjholmes927@gmail.com']
  spec.homepage = 'https://github.com/jjholmes927/rspec-ci-prettify'

  spec.summary = 'rspec formatter that gives a more readable output on CI runs (specifically Github actions)'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.files = Dir['lib/**/*']

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/jjholmes927/rspec-ci-prettify'

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_runtime_dependency 'rspec-core', '~> 3.0'
  spec.add_development_dependency 'pry', '~> 0.14.1'
  spec.add_development_dependency 'rspec', '~> 3.2'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
