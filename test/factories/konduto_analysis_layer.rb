# frozen_string_literal: true

FactoryGirl.define do
  factory :konduto_analysis_layer do
    recommendation 'REVIEW'
    original_recommendation 'REVIEW'
    is_exploring false
    analysis_type 'FRAUD'
    score 0.3017217853308364
  end
end
