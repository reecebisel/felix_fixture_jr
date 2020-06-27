# frozen_string_literal: true

require "spec_helper"
require "./lib/felix_fixture_jr"

RSpec.describe FelixFixtureJr do
  let(:blacklisted_attributes) do
    FelixFixtureJr.config.blacklisted_attributes
  end

  let(:fixture_directory) do
    FelixFixtureJr.config.fixture_directory
  end

  let(:default_call_chain) do
    FelixFixtureJr.config.default_call_chain
  end

  it "allows configuration to update config" do
    FelixFixtureJr.configure do |config|
      config.fixture_directory   = "../test/fixtures/"
      config.default_call_chain  = ["some", "call", "chain"]
      config.blacklisted_attributes << "password"
    end

    expect(blacklisted_attributes).to eq %w[created_at updated_at password]
    expect(fixture_directory).to eq "../test/fixtures/"
    expect(default_call_chain).to eq %w[some call chain]
  end
end
