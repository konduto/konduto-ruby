# frozen_string_literal: true

require 'minitest/autorun'
require 'factory_girl'

class KondutoCustomerTest < MiniTest::Test
  include FactoryGirl::Syntax::Methods

  def test_validation
    customer = KondutoCustomer.new
    refute customer.valid?, 'customer should be invalid without id'

    customer.id = 'customer1'
    refute customer.valid?, 'customer should be invalid without name'

    customer.name = 'José da Silva'
    refute customer.valid?, 'customer should be invalid without email'

    customer.email = 'jose.silva@gmail.com'
    assert customer.valid?, 'customer should be valid'
  end

  def test_serialization
    customer = build(:konduto_customer, :complete)
    customerJSON = load_resource('customer.json')

    assert_equal customer.to_hash, customerJSON, 'serialization failed'

    customer = KondutoCustomer.new customerJSON

    assert_equal customer.to_hash, customerJSON, 'deserialization failed'
  end
end
