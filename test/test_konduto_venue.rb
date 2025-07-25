# frozen_string_literal: true

require 'Minitest/autorun'
require 'factory_bot'

class KondutoVenueTest < Minitest::Test
  include FactoryBot::Syntax::Methods

  def test_serialization
    venue = build(:konduto_venue)

    expectedJSON = load_resource('venue.json')
    actualJSON   = venue.to_hash

    assert_equal expectedJSON, actualJSON, 'venue serialization failed'

    venue_from_json = KondutoVenue.new expectedJSON

    assert_equal venue, venue_from_json, 'venue deserialization failed'
  end
end
