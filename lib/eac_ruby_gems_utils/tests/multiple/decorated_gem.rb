# frozen_string_literal: true

module EacRubyGemsUtils
  module Tests
    class Multiple
      class DecoratedGem < ::SimpleDelegator
        def tests
          [::EacRubyGemsUtils::Tests::Minitest.new(__getobj__),
           ::EacRubyGemsUtils::Tests::Rspec.new(__getobj__)]
        end
      end
    end
  end
end
