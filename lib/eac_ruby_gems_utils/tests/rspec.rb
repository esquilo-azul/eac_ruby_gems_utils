# frozen_string_literal: true

require 'eac_ruby_gems_utils/tests/base'

module EacRubyGemsUtils
  module Tests
    class Rspec < ::EacRubyUtils::Gem::Test
      def bundle_exec_args
        %w[rspec]
      end

      def dependency_gem
        'rspec-core'
      end

      def test_directory
        'spec'
      end
    end
  end
end
