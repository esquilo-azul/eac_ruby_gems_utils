# frozen_string_literal: true

require 'eac_ruby_gems_utils/tests/minitest'
require 'eac_ruby_gems_utils/tests/rspec'
require 'eac_ruby_utils/core_ext'

module EacRubyGemsUtils
  module Tests
    class Multiple
      require_sub __FILE__
      enable_console_speaker
      enable_simple_cache
      common_constructor :gems, :options, default: [{}]
      set_callback :initialize, :after, :run

      def ok?
        failed_tests.none?
      end

      def only
        options[:only]
      end

      private

      def all_tests_uncached
        decorated_gems.flat_map(&:tests)
      end

      def prepare_all_gems
        infom 'Bundling all gems...'
        decorated_gems.each do |gem|
          next unless gem.gemfile_path.exist?

          infov 'Bundle install', gem
          gem.bundle.execute!
        end
      end

      def decorated_gems_uncached
        r = gems
        r = r.select { |gem| only.include?(gem.name) } if only.present?
        r.map { |gem| DecoratedGem.new(gem) }
      end

      def failed_tests_uncached
        all_tests.select { |r| r.result == ::EacRubyGemsUtils::Tests::Base::RESULT_FAILED }
      end

      def final_results_banner
        if failed_tests.any?
          warn 'Some test did not pass:'
          failed_tests.each do |test|
            infov '  * Test', test
            infov '    * STDOUT', test.stdout_cache.content_path
            infov '    * STDERR', test.stderr_cache.content_path
          end
        else
          success 'All tests passed'
        end
      end

      def run
        start_banner
        prepare_all_gems
        test_all_gems
        final_results_banner
      end

      def start_banner
        infov 'Gems to test', decorated_gems.count
      end

      def test_all_gems
        infom 'Running tests...'
        all_tests.each do |test|
          infov test, Result.new(test.result).tag
        end
      end
    end
  end
end
