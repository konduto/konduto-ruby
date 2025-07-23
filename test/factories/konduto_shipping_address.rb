# frozen_string_literal: true

FactoryGirl.define do
  factory :konduto_shipping_address do
    name 'Konduto'
    address1 'R. Teodoro Sampaio, 2393'
    address2 'CJ. 111'
    zip '05406-200'
    city 'São Paulo'
    state 'SP'
    country 'BR'
    estimated_date "2022-02-15T12:00:25Z"
    value 20.0
  end
end
