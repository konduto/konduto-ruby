# frozen_string_literal: true

# These lines must go first
require 'factory_bot'
require 'simplecov'
SimpleCov.start

def load_resource(resource)
  JSON.parse(File.read("test/resources/#{resource}"))
end

FactoryBot.find_definitions
