# frozen_string_literal: true

require 'eac_ruby_gems_utils/tests/base'

module EacRubyGemsUtils
  module Tests
    class Rspec < ::EacRubyGemsUtils::Tests::Base
      def exec_args
        %w[exec rspec]
      end

      def exec_method
        :bundle
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
