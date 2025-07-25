# frozen_string_literal: true

require 'Minitest/autorun'
require 'factory_bot'

class KondutoEventTest < Minitest::Test
  include FactoryBot::Syntax::Methods

  def test_serialization
    event = build(:konduto_event)

    expectedJSON = load_resource('events.json').first
    actualJSON   = event.to_hash

    assert_equal expectedJSON, actualJSON, 'Event serialization failed'

    event_from_json = KondutoEvent.new expectedJSON

    assert_equal event, event_from_json, 'Event deserialization failed'
  end
end
