# frozen_string_literal: true

class KondutoItem < KondutoBase
  attributes :sku, :category, :name, :description, :product_code, :unit_cost, :quantity,
             :discount, :delivery_type, :delivery_sla_in_minutes, :seller_id
  attribute created_at: :date
end
