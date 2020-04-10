# frozen_string_literal: true

require 'eac_ruby_gems_utils/tests/base'

module EacRubyGemsUtils
  module Tests
    class Minitest < ::EacRubyGemsUtils::Tests::Base
      def bundle_exec_args
        ['rake', '--rakefile', gem.rakefile_path, 'test']
      end

      def dependency_gem
        'minitest'
      end

      def elegible?
        super && gem.rakefile_path.exist?
      end

      def test_directory
        'test'
      end
    end
  end
end
