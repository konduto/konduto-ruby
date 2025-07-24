# frozen_string_literal: true

class KondutoDelivery < KondutoBase
  attributes :delivery_company, :delivery_method, :estimated_shipping_date, :estimated_delivery_date
end
