# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'eac_ruby_gems_utils/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'eac_ruby_gems_utils'
  s.version     = ::EacRubyGemsUtils::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Utilities for Ruby gems development.'
  s.license     = 'GPL3'

  s.files = Dir['{lib}/**/*', 'LICENSE', 'README.rdoc']
end
