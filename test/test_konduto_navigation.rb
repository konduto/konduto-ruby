# frozen_string_literal: true

require 'Minitest/autorun'
require 'factory_girl'

class TestKondutoNavigation < Minitest::Test
  include FactoryGirl::Syntax::Methods

  def test_serialization
    navigation = build(:konduto_navigation)
    navigation_JSON = load_resource('navigation.json')

    assert_equal navigation.to_hash, navigation_JSON, 'serialization falied'
  end
end
