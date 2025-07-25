# frozen_string_literal: true

require 'Minitest/autorun'
require 'factory_bot'

class KondutoHotelTest < Minitest::Test
  include FactoryBot::Syntax::Methods

  def test_serialization
    hotel = build(:konduto_hotel)

    expectedJSON = load_resource('hotel.json')
    actualJSON   = hotel.to_hash

    assert_equal expectedJSON, actualJSON, 'Hotel serialization failed'

    hotel_from_json = KondutoHotel.new expectedJSON

    assert_equal hotel, hotel_from_json, 'Hotel deserialization failed'
  end
end
