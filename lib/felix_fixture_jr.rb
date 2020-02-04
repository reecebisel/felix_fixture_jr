# frozen_string_literal: true

require 'forwardable'

require_relative "felix_fixture_jr/config"
require_relative "felix_fixture_jr/definition"
require_relative "felix_fixture_jr/null_constant"

module FelixFixtureJr
  extend self
  extend Forwardable

  def_delegators :config, :default_call_chain,
                          :fixture_directory

  def configure
    yield config
  end

  def config
    @config ||= Config.new
  end
end
