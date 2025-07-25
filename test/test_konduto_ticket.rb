# frozen_string_literal: true

require 'Minitest/autorun'
require 'factory_girl'

class KondutoTicketTest < Minitest::Test
  include FactoryGirl::Syntax::Methods

  def test_serialization
    ticket = build(:konduto_ticket)

    expectedJSON = load_resource('ticket.json')
    actualJSON   = ticket.to_hash

    assert_equal expectedJSON, actualJSON, 'ticket serialization failed'

    ticket_from_json = KondutoTicket.new expectedJSON

    assert_equal ticket, ticket_from_json, 'ticket deserialization failed'
  end
end
