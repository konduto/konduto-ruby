# frozen_string_literal: true

FactoryBot.define do
  factory :konduto_venue do
    name { 'Estádio do Maracanã' }
    capacity { 8000 }
    address { 'Av. Maracanã s/n' }
    city { 'Rio de Janeiro' }
    state { 'RJ' }
    country { 'BR' }
  end
end
