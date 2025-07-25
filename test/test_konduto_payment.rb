# frozen_string_literal: true

require 'Minitest/autorun'
require 'factory_girl'

class KondutoPaymentTest < Minitest::Test
  include FactoryGirl::Syntax::Methods

  def test_serialization
    payments = []
    payments << build(:konduto_payment, :credit_card)
    payments << build(:konduto_payment, :voucher)
    payment_json = load_resource('payments.json')

    assert_equal payment_json, payments.map(&:to_hash), 'serialization failed'
  end
end
