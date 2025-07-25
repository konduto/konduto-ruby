# frozen_string_literal: true

FactoryGirl.define do
  factory :konduto_triggered_rule do
    priority(-2)
    name 'CPFs Monitorados'
    analysis_type 'FRAUD'
    decision 'REVIEW'
  end
end
