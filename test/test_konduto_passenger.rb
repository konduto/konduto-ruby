# frozen_string_literal: true

require 'Minitest/autorun'
require 'factory_bot'

class TestKondutoPassenger < Minitest::Test
  include FactoryBot::Syntax::Methods

  def test_validation
    passenger = KondutoPassenger.new
    refute passenger.valid?, 'should be invalid without name'

    passenger.name = 'Milton Tavares'
    refute passenger.valid?, 'should be invalid without document'

    passenger.document = 'A1B2C3D4'
    refute passenger.valid?, 'should be invalid without document type'

    passenger.document_type = :passport
    refute passenger.valid?, 'should be invalid without nationality'

    passenger.nationality = '123'
    refute passenger.valid?, 'should be invalid if not a 2 chars string'
    passenger.nationality = 'BR'
    assert passenger.valid?, 'should be a valid passenger'
  end

  def test_serialization
    passengerJSON = load_resource('passenger.json')
    passenger = build(:konduto_passenger, :fixed_complete)

    assert_equal passengerJSON, passenger.to_hash, 'serialization failed'
  end
end
