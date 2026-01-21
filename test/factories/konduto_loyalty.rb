# frozen_string_literal: true

FactoryBot.define do
  factory :konduto_loyalty do
    program { 'advantage' }
    category { 'gold' }
  end
end
