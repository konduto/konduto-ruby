# frozen_string_literal: true

require 'minitest/autorun'
require 'factory_bot'

class KondutoExternalDeviceTest < Minitest::Test
  include FactoryBot::Syntax::Methods

  def test_serialization
    ext_device = build(:konduto_external_device)

    expectedJSON = load_resource('external_device.json')
    actualJSON   = ext_device.to_hash

    assert_equal expectedJSON, actualJSON, 'External Device serialization failed'

    ext_device_from_json = KondutoExternalDevice.new expectedJSON

    assert_equal ext_device, ext_device_from_json, 'External Device deserialization failed'
  end
end
