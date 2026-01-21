# frozen_string_literal: true

FactoryBot.define do
  factory :konduto_options do
    real_time { true }
    sales_channel { 'app' }
  end
end
