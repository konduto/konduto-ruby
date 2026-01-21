# frozen_string_literal: true

require 'minitest/autorun'
require 'factory_bot'

class TestKondutoGeolocation < Minitest::Test
  include FactoryBot::Syntax::Methods

  def test_serialization
    geolocation = build(:konduto_geolocation)
    geolocationJSON = load_resource('geolocation.json')

    assert_equal geolocation.to_hash, geolocationJSON, 'serialization failed'
  end
end
