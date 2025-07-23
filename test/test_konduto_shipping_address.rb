# frozen_string_literal: true

require 'minitest/autorun'
require 'factory_girl'

class KondutoShippingAddressTest < MiniTest::Test
  include FactoryGirl::Syntax::Methods

  def test_serialization
    address = build(:konduto_shipping_address)

    expectedJSON = load_resource('shipping_address.json')
    actualJSON   = address.to_hash

    assert_equal expectedJSON, actualJSON, 'address serialization failed'

    address_from_json = KondutoShippingAddress.new expectedJSON

    assert_equal address, address_from_json, 'address deserialization failed'
  end
end
