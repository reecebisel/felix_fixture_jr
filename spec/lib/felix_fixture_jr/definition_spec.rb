# frozen_string_literal: true

require "./lib/felix_fixture_jr/definition"
require "./lib/felix_fixture_jr.rb"
require "spec_helper"

class Totez
  def self.table_name
    "totez"
  end
end

class TotezDefintion < FelixFixtureJr::Definition; end

RSpec.describe FelixFixtureJr::Definition do
  context "minimal setup for class" do
    before do
      FelixFixtureJr.configure do |config|
        config.fixture_directory = "./spec/support"
      end

      @subject = described_class.new(Totez)
    end

    it "#slug_prefix" do
      expect(@subject.slug_prefix).to eq("totez")
    end

    it "#file" do
      expect(@subject.file).to eq File.open("../support/totez.yml")
    end

    it "#fixturize" do
      expect(@subject.fixturize).to be_present
      expect(YAML.parse(@subject.fixturize))
    end

    it "#build" do
      expect(@subject.fixture_file.size).to eq 0
      @subject.build
      expect(@subject.fixture_file.size).to be > 0
    end

    it "#constant" do
      expect(@subject.constant).to eq(Totez)
    end
  end
end
