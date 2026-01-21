# frozen_string_literal: true

require 'minitest/autorun'
require 'factory_bot'

class KondutoVehicleTest < Minitest::Test
  include FactoryBot::Syntax::Methods

  def test_serialization
    vehicle = build(:konduto_vehicle)

    expectedJSON = load_resource('vehicle.json')
    actualJSON   = vehicle.to_hash

    assert_equal expectedJSON, actualJSON, 'vehicle serialization failed'

    vehicle_from_json = KondutoVehicle.new expectedJSON

    assert_equal vehicle, vehicle_from_json, 'vehicle deserialization failed'
  end
end
