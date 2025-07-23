# frozen_string_literal: true

require 'date'

FactoryGirl.define do
  factory :konduto_customer do
    id '1'
    name 'José da Silva'
    email 'jose.silva@gmail.com'

    trait :complete do
      new? false
      vip? false
      phone1 '11987654321'
      phone2 '1133333333'
      tax_id '01234567890'
      created_at Date.new(2015, 6, 9)
      dob Date.new(1969, 7, 20)
      document_type 'cpf'
      type 'A1'
      risk_level 'low'
      risk_score 0.5
      mother_name 'Maria Silva'
    end
  end
end
