# frozen_string_literal: true

FactoryGirl.define do
  factory :konduto_delivery do
    delivery_company 'GFL'
    delivery_method 'retira_loja'
    estimated_shipping_date '2021-05-06'
    estimated_delivery_date '2021-05-06'
  end
end
