# frozen_string_literal: true

require 'minitest/autorun'
require 'factory_girl'

class KondutoTenantTest < MiniTest::Test
  include FactoryGirl::Syntax::Methods

  def test_serialization
    tenant = build(:konduto_tenant)

    expectedJSON = load_resource('tenant.json')
    actualJSON   = tenant.to_hash

    assert_equal expectedJSON, actualJSON, 'tenant serialization failed'

    tenant_from_json = KondutoTenant.new expectedJSON

    assert_equal tenant, tenant_from_json, 'tenant deserialization failed'
  end
end
