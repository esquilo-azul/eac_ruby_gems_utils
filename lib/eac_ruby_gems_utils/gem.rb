# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/envs'

module EacRubyGemsUtils
  class Gem
    require_sub __FILE__
    enable_simple_cache

    common_constructor :root do
      @root = ::Pathname.new(root).expand_path
    end

    def to_s
      name
    end

    def bundle(*args)
      ::EacRubyGemsUtils::Gem::Command.new(self, %w[bundle] + args).envvar_gemfile
    end

    def gemfile_lock_gem_version(gem_name)
      gemfile_lock_content.specs.find { |gem| gem.name == gem_name }.if_present(&:version)
    end

    def gemfile_lock_content
      ::Bundler::LockfileParser.new(::Bundler.read_file(gemfile_lock_path))
    end

    def rake(*args)
      raise "File \"#{rakefile_path}\" does not exist" unless rakefile_path.exist?

      bundle('exec', 'rake', '--rakefile', rakefile_path, *args)
    end

    private

    def gemfile_path_uncached
      root.join('Gemfile')
    end

    def gemfile_lock_path_uncached
      root.join('Gemfile.lock')
    end

    def rakefile_path_uncached
      root.join('Rakefile')
    end
  end
end
