# frozen_string_literal: true

class KondutoItem < KondutoBase
  attributes :sku, :category, :name, :description, :product_code, :unit_cost, :quantity,
             :discount, :image
  attribute created_at: :date
end
