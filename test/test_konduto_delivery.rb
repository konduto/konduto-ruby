# frozen_string_literal: true

require 'Minitest/autorun'
require 'factory_bot'

class KondutoDeliveryTest < Minitest::Test
  include FactoryBot::Syntax::Methods

  def setup
    @json = load_resource('delivery.json')
  end

  def test_serialization
    delivery = build(:konduto_delivery)

    assert_equal @json, delivery.to_hash, 'serialization failed'
  end

  def test_it_should_be_accessible_after_serialization
    delivery = build(:konduto_delivery)

    assert_equal 'GFL', delivery.to_hash['delivery_company']
    assert_equal 'retira_loja', delivery.to_hash['delivery_method']
    assert_equal '2021-05-06', delivery.to_hash['estimated_shipping_date']
    assert_equal '2021-05-06', delivery.to_hash['estimated_delivery_date']
  end
end
