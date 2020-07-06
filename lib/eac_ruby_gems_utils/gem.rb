# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/envs'

module EacRubyGemsUtils
  class Gem
    require_sub __FILE__
    enable_simple_cache

    GEMSPEC_EXTNAME = '.gemspec'

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

    def name
      name_by_gemspec || name_by_path
    end

    def name_by_gemspec
      gemspec_path.if_present { |v| v.basename(GEMSPEC_EXTNAME).to_path }
    end

    def name_by_path
      root.basename.to_s
    end

    def namespace_parts
      name.split('-')
    end

    def rake(*args)
      raise "File \"#{rakefile_path}\" does not exist" unless rakefile_path.exist?

      bundle('exec', 'rake', '--rakefile', rakefile_path, *args)
    end

    def version
      /VERSION\s*=\s*[\'\"]([^\'\"]+)[\'\"]/.if_match(version_file.read) { |m| m[1] }
    end

    private

    def gemfile_path_uncached
      root.join('Gemfile')
    end

    def gemfile_lock_path_uncached
      root.join('Gemfile.lock')
    end

    def gemspec_path_uncached
      ::Pathname.glob("#{root.to_path}/*#{GEMSPEC_EXTNAME}").first
    end

    def rakefile_path_uncached
      root.join('Rakefile')
    end

    def version_file_uncached
      root.join('lib', *namespace_parts, 'version.rb')
    end
  end
end
