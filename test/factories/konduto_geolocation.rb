# frozen_string_literal: true

FactoryBot.define do
  factory :konduto_geolocation do
    city { 'São Paulo' }
    state { 'SP' }
    country { 'BR' }
  end
end
