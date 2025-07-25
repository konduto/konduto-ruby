# frozen_string_literal: true

require 'Minitest/autorun'
require 'factory_girl'

class KondutoOptionsTest < Minitest::Test
  include FactoryGirl::Syntax::Methods

  def test_serialization
    options = build(:konduto_options)

    expectedJSON = load_resource('options.json')
    actualJSON   = options.to_hash

    assert_equal expectedJSON, actualJSON, 'options serialization failed'

    options_from_json = KondutoOptions.new expectedJSON

    assert_equal options, options_from_json, 'options deserialization failed'
  end
end
