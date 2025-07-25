# frozen_string_literal: true

require 'Minitest/autorun'
require 'factory_girl'
require 'konduto-ruby'

class KondutoOrderTest < Minitest::Test
  include FactoryGirl::Syntax::Methods

  def setup
    FactoryGirl.reload
  end

  def test_valid
    order = KondutoOrder.new
    refute order.valid?, 'order should be invalid without id'

    order.id = 'order1'
    refute order.valid?, 'order should be invalid without total amount'

    order.total_amount = 120.1
    refute order.valid?, 'order should be invalid without customer'

    order.customer = KondutoCustomer.new
    assert order.valid?, 'order should be valid'
  end

  def test_serialization
    order = build(:konduto_order, :complete)
    orderJSON = load_resource('order.json')

    assert_equal orderJSON, order.to_hash, 'order should be valid'

    deserialized_order = KondutoOrder.new orderJSON

    assert_equal order, deserialized_order, 'deserialization failed'
  end

  def test_invalid_serialization
    order = KondutoOrder.new
    assert_raises(RuntimeError) { order.to_json }
  end
end
