# frozen_string_literal: true

require 'Minitest/autorun'
require 'factory_bot'

class KondutoTravelTest < Minitest::Test
  include FactoryBot::Syntax::Methods

  def test_validation
    travel = KondutoTravel.new
    refute travel.valid?, 'should be invalid without a type'

    travel.type = :flight
    refute travel.valid?, 'should be invalid without departure leg'

    travel.departure = build(:konduto_flight_leg)
    refute travel.valid?, 'should be invalid without passengers'

    travel.passengers = build_list(:konduto_passenger, 2)
    assert travel.valid?, 'should be valid without a return leg'

    travel.return = build(:konduto_flight_leg)
    assert travel.valid?, 'should continue value'
  end
end
