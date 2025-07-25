# frozen_string_literal: true

FactoryBot.define do
  factory :konduto_seller do
    id { 'seller_id' }
    name { 'Seller Name' }
    created_at { Date.new(2015, 6, 9) }
  end
end
