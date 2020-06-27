# frozen_string_literal: true

require "./lib/felix_fixture_jr/definition"
require "./lib/felix_fixture_jr.rb"
require "spec_helper"

class Totez
  attr_reader :id, :stuff, :things

  def self.table_name
    "totez"
  end

  def self.all
    [
      Totez.new(1),
      Totez.new(2),
      Totez.new(3),
    ]
  end

  def initialize(id)
    @things = "things"
    @stuff  = "stuff"
    @id     = id
  end

  def attributes
    {
      id: id,
      stuff: stuff,
      things: things
    }
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

    after do
      File.write(@subject.file.path, "", mode: "w")
    end

    it "#slug_prefix" do
      expect(@subject.slug_prefix).to eq("totez")
    end

    it "#file" do
      expect(
        FileUtils.identical?(@subject.file, File.open("./spec/support/totez.yml"))
      ).to be true
    end

    it "#fixtures" do
      expect(@subject.fixtures.length).to eq(3)

      @subject.fixtures.each do |fixture|
        expect(YAML.parse(fixture))
      end
    end

    it "#build" do
      expect(@subject.file_size).to eq 0
      @subject.build
      expect(@subject.file_size).to be > 0
    end

    it "#build creates new fixture file" do
      File.delete(@subject.file)

      expect(@subject.file_size).to eq 0
      @subject.build
      expect(@subject.file_size).to be > 0
    end

    it "#constant" do
      expect(@subject.constant).to eq(Totez)
    end
  end
end
