# frozen_string_literal: true

require_relative "null_constant"
require_relative "../felix_fixture_jr"

module FelixFixtureJr
  class Definition
    attr_writer :file, :slug_prefix

    attr_accessor :constant,
                  :include_index,
                  :parent

    def initialize(constant, parent: FelixFixtureJr::NullConstant)
      @constant = constant
      @parent   = parent
    end

    def slug_prefix
      @slug_prefix ||= [parent_name, constant.table_name].join
    end

    def file
      File.open(path)
    end

    def path
      @path ||= [FelixFixtureJr.fixture_directory, file_name].join("/")
    end

    def fixturize
      @constant.all.each_with_index.map do |instance, index|
        {
          slug(index: index) => instance.except(blocked_attributes)
        }.to_yaml
      end
    end

    def blacklisted_attributes
      @blacklisted_attributes ||= {}
    end

    private

    def parent_name
      parent&.table_name || FelixFixtureJr.god_object.table_name
    end

    def blocked_attributes
      FelixFixtureJr.blacklisted_attributes.merge(blacklisted_attributes)
    end

    def slug(index: nil)
      @slug ||= [slug_prefix, (index if include_index)].join('_')
    end

    def file_name
      @file_name ||= [@constant.table_name, ".yml"].join
    end
  end
end
