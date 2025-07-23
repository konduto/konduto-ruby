# frozen_string_literal: true

require 'minitest/autorun'
require 'factory_girl'

class KondutoAgentTest < MiniTest::Test
  include FactoryGirl::Syntax::Methods

  def test_serialization
    agent = build(:konduto_agent)

    expectedJSON = load_resource('agent.json')
    actualJSON   = agent.to_hash

    assert_equal expectedJSON, actualJSON, 'agent serialization failed'

    agent_from_json = KondutoAgent.new expectedJSON

    assert_equal agent, agent_from_json, 'agent deserialization failed'
  end
end
