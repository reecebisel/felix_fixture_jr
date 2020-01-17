# frozen_string_literal: true

module FelixFixtureJr
  class Config
    attr_accessor :blacklisted_attributes,
                  :default_call_chain,
                  :fixture_directory


    def blacklisted_attributes
      @blacklisted_attributes ||= %w[
        created_at
        updated_at
      ]
    end
  end
end
