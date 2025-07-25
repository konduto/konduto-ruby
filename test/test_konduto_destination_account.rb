# frozen_string_literal: true

require 'Minitest/autorun'
require 'factory_girl'

class KondutoDestinationAccountTest < Minitest::Test
  include FactoryGirl::Syntax::Methods

  def test_serialization
    dest_account = build(:konduto_destination_account)

    expectedJSON = load_resource('destination_accounts.json').first
    actualJSON   = dest_account.to_hash

    assert_equal expectedJSON, actualJSON, 'Destination account serialization failed'

    dest_account_from_json = KondutoDestinationAccount.new expectedJSON

    assert_equal dest_account, dest_account_from_json, 'Destination account deserialization failed'
  end
end
