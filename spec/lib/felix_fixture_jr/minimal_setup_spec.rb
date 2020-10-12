# frozen_string_literal: true

require "./lib/felix_fixture_jr/definition"
require "./lib/felix_fixture_jr.rb"
require "spec_helper"

class UserFixture < User
  include FelixFixtureJr::Definition
end

RSpec.describe UserFixture do
  context "minimal setup for class" do
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

    let(:subject) { described_class.new }

    after do
      File.write(subject.file.path, "", mode: "w")
      User.destroy_all
    end

    it "#slug_prefix" do
      expect(subject.slug_prefix).to eq("users")
    end

    it "#file" do
      expect(
        FileUtils.identical?(subject.file, File.open("./spec/support/users.yml"))
      ).to be true
    end

    it "#fixtures" do
      expect(subject.fixtures.length).to eq(3)

      subject.fixtures.each do |fixture|
        expect(YAML.parse(fixture))
      end
    end

    it "#build" do
      expect(subject.file_size).to eq 0
      subject.build
      expect(subject.file_size).to be > 0
    end

    it "#build creates new fixture file" do
      File.delete(subject.file)

      expect(subject.file_size).to eq 0
      subject.build
      expect(subject.file_size).to be > 0
    end

    it "#constant" do
      expect(subject.constant).to eq(User)
    end
  end
end
