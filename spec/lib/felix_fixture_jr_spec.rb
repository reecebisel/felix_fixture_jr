# frozen_string_literal: true

require "spec_helper"
require "./lib/felix_fixture_jr"

require "pry"

RSpec.describe FelixFixtureJr do
  it "allows configuration to update config" do
    FelixFixtureJr.configure do |config|
      config.fixture_directory   = "../test/fixtures/"
      config.default_call_chain  = ["some", "call", "chain"]
      config.blacklisted_attributes << "password"
    end

    expect(FelixFixtureJr.config.blacklisted_attributes).to eq %w[created_at updated_at password]
    expect(FelixFixtureJr.config.fixture_directory).to eq "../test/fixtures/"
    expect(FelixFixtureJr.config.default_call_chain).to eq %w[some call chain]
  end
end
