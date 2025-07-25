# frozen_string_literal: true

require 'Minitest/autorun'
require 'date'
require 'konduto-ruby'

class TestKondutoFlightLeg < Minitest::Test
  def setup
    @params = {
      origin_airport: 'CGH',
      destination_airport: 'SDU',
      date: 2015 - 0o5 - 0o7,
      fare_basis: 'Y',
      number_of_connections: 1,
      class: 'economy'
    }
  end

  def test_validation
    travel_leg = KondutoFlightLeg.new
    refute travel_leg.valid?, 'travel leg should be invalid'
    # is invalid if airport IATA code is missing or not formed by 3 letters
    travel_leg.origin_airport = '123'
    refute travel_leg.valid?, 'airport name must be formed by letters'

    travel_leg.origin_airport = 'CGH'
    refute travel_leg.valid?, 'travel leg must have a destination_airport'

    travel_leg.destination_airport = '123'
    refute travel_leg.valid?, 'airport name must be formed by letters'

    travel_leg.destination_airport = 'SDU'
    assert travel_leg.valid?, 'travel leg should be valid'
  end

  def test_serialization
    travel_leg = KondutoFlightLeg.new @params
    assert_equal travel_leg.to_hash, @params.stringify_keys, 'serialization failed'
  end
end
