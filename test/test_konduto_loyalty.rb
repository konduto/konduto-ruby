# frozen_string_literal: true

require 'minitest/autorun'
require 'factory_girl'

class KondutoLoyaltyTest < MiniTest::Test
  include FactoryGirl::Syntax::Methods

  def test_serialization
    loyalty = build(:konduto_loyalty)

    expectedJSON = load_resource('loyalty.json')
    actualJSON   = loyalty.to_hash

    assert_equal expectedJSON, actualJSON, 'loyalty serialization failed'

    loyalty_from_json = KondutoLoyalty.new expectedJSON

    assert_equal loyalty, loyalty_from_json, 'loyalty deserialization failed'
  end
end
