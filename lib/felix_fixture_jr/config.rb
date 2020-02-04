# frozen_string_literal: true

require 'pathname'

module FelixFixtureJr
  class Config
    attr_writer :blacklisted_attributes,
                :default_call_chain,
                :fixture_directory

    def blacklisted_attributes
      @blacklisted_attributes ||= %w[
        created_at
        updated_at
      ]
    end

    def default_call_chain
      @default_call_chain ||= []
    end

    def fixture_directory
      @fixture_directory ||= Pathname.new("./test/fixtures")
    end
  end
end
