# frozen_string_literal: true

require 'Minitest/autorun'
require 'factory_bot'

class KondutoOriginAccountTest < Minitest::Test
  include FactoryBot::Syntax::Methods

  def test_serialization
    origin_account = build(:konduto_origin_account)

    expectedJSON = load_resource('origin_account.json')
    actualJSON   = origin_account.to_hash

    assert_equal expectedJSON, actualJSON, 'origin account serialization failed'

    origin_account_from_json = KondutoOriginAccount.new expectedJSON

    assert_equal origin_account, origin_account_from_json, 'origin account deserialization failed'
  end
end
