# frozen_string_literal: true

require 'minitest/autorun'
require 'factory_girl'

class KondutoRoomTest < MiniTest::Test
  include FactoryGirl::Syntax::Methods

  def test_serialization
    room_account = build(:konduto_room)

    expectedJSON = load_resource('room.json')
    actualJSON   = room_account.to_hash

    assert_equal expectedJSON, actualJSON, 'room serialization failed'

    room_from_json = KondutoRoom.new expectedJSON

    assert_equal room_account, room_from_json, 'room deserialization failed'
  end
end
