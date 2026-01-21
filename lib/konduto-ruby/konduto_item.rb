# frozen_string_literal: true

class KondutoItem < KondutoBase
  attributes :sku, :category, :name, :description, :product_code, :unit_cost, :quantity,
             :discount, :delivery_type, :delivery_sla_in_minutes, :seller_id, :image
  attribute created_at: :date

  def to_hash
    item_as_hash = super.to_hash
    item_as_hash = rename_attribute_on_hash('delivery_sla_in_minutes', 'deliverySlaInMinutes', item_as_hash)
    item_as_hash = rename_attribute_on_hash('delivery_type', 'deliveryType', item_as_hash)
    rename_attribute_on_hash('seller_id', 'sellerId', item_as_hash)
  end
end
