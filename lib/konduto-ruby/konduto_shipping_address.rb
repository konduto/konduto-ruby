# frozen_string_literal: true

class KondutoShippingAddress < KondutoAddress
  attributes :estimated_date, :value

  def to_hash
    shipping_address_as_hash = super.to_hash
    rename_attribute_on_hash('estimated_date', 'estimatedDate', shipping_address_as_hash)
  end
end
