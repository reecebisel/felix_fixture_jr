# frozen_string_literal: true

require_relative "felix_fixture_jr/config"
require_relative "felix_fixture_jr/definition"
require_relative "felix_fixture_jr/null_constant"

module FelixFixtureJr
  extend self

  def configure
    yield config
  end

  def config
    @config ||= Config.new
  end
end
