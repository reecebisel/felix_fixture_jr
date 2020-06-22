# frozen_string_literal: true

require_relative "null_constant"
require_relative "../felix_fixture_jr"

require "active_record"

module FelixFixtureJr
  class Definition
    attr_writer :file, :slug_prefix

    attr_accessor :constant,
                  :include_index,
                  :parent

    attr_reader :blacklisted_attributes

    def initialize(constant, parent: FelixFixtureJr::NullConstant)
      @constant               = constant
      @parent                 = parent
      @blacklisted_attributes = []
    end

    def build
      File.write(path) do |file|
        fixtures.each do |fixture|
          file << fixture.gsub("---\n", "")
        end
      end
    end

    def slug_prefix
      @slug_prefix ||= [parent_name, constant.table_name].join
    end

    def file
      File.open(path)
    end

    def file_size
      file.size
    end

    def path
      @path ||= [FelixFixtureJr.fixture_directory, file_name].join("/")
    end

    def fixtures
      @constant.all.each_with_index.map do |instance, index|
        {
          slug(index: index) => filter(instance.attributes)
        }.to_yaml
      end
    end

    private

    def parent_name
      parent&.table_name || FelixFixtureJr.default_call_chain
    end

    def blocked_attributes
      FelixFixtureJr.blacklisted_attributes + blacklisted_attributes
    end

    def slug(index: nil)
      @slug ||= [slug_prefix, (index if include_index)].join('_')
    end

    def file_name
      @file_name ||= [@constant.table_name, ".yml"].join
    end

    def filter(attributes)
      blocked_attributes.each do |attr|
        attributes.delete(attr)
      end

      attributes
    end
  end
end
