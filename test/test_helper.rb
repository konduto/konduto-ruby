# frozen_string_literal: true

require 'factory_girl'
require 'simplecov'            # These two lines must go first
SimpleCov.start

def load_resource(resource)
  JSON.parse(File.read("test/resources/#{resource}"))
end

FactoryGirl.find_definitions
