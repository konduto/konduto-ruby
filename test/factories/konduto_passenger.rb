# frozen_string_literal: true

require 'date'

FactoryBot.define do
  factory :konduto_passenger do
    frequent_traveler { false }
    name { 'Júlia da Silva' }
    nationality { 'BR' }
    special_needs { false }
    document_type { :passport }

    trait :basic do
      name { 'Júlia da Silva' }
      nationality { 'BR' }
      special_needs { false }
    end

    trait :complete do
      dob { Date.new(1970, 1, 1) }
      nationality { 'BR' }
      frequent_traveler { true }
      special_needs { false }
    end

    trait :fixed_complete do
      name { 'Júlia da Silva' }
      document { 'A1B2C3D4' }
      document_type { :id }
      dob { Date.new(1970, 1, 1) }
      nationality { 'BR' }
      frequent_traveler { true }
      special_needs { false }
      loyalty factory: :konduto_loyalty, strategy: :build
    end
  end
end
