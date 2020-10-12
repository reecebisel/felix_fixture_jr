# frozen_string_literal: true

require "./lib/felix_fixture_jr/definition"
require "./lib/felix_fixture_jr.rb"
require "support/shared_definition"
require "spec_helper"

class UserFixture < User
  include FelixFixtureJr::Definition
end

RSpec.describe UserFixture do
  before do
    3.times do |i|
      User.create(
        name: "name_#{i}",
        email: "totez_#{i}@example.com",
        admin: i % 2 == 0 ? true : false
      )
    end

    FelixFixtureJr.configure do |config|
      config.fixture_directory = "./spec/support"
    end
  end

  it_behaves_like "fixture definition", User, "./spec/support/users.yml"
end
