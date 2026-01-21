# frozen_string_literal: true

require 'minitest/autorun'
require 'factory_bot'

class KondutoOwnerTest < Minitest::Test
  include FactoryBot::Syntax::Methods

  def test_serialization
    owner = build(:konduto_owner)

    expectedJSON = load_resource('owner.json')
    actualJSON   = owner.to_hash

    assert_equal expectedJSON, actualJSON, 'owner serialization failed'

    owner_from_json = KondutoOwner.new expectedJSON

    assert_equal owner, owner_from_json, 'owner deserialization failed'
  end
end
