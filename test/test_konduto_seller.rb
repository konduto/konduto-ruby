# frozen_string_literal: true

require 'Minitest/autorun'
require 'factory_bot'

class TestKondutoSeller < Minitest::Test
  include FactoryBot::Syntax::Methods

  def test_serialization
    seller = build(:konduto_seller)
    sellerJSON = load_resource('seller.json')

    assert_equal sellerJSON, seller.to_hash, 'serialization failed'
  end
end
