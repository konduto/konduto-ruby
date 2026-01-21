# frozen_string_literal: true

require 'minitest/autorun'
require 'factory_bot'

class KondutoGuestTest < Minitest::Test
  include FactoryBot::Syntax::Methods

  def test_serialization
    guest = build(:konduto_guest)

    expectedJSON = load_resource('guest.json')
    actualJSON   = guest.to_hash

    assert_equal expectedJSON, actualJSON, 'Guest serialization failed'

    guest_from_json = KondutoGuest.new expectedJSON

    assert_equal guest, guest_from_json, 'Guest deserialization failed'
  end
end
