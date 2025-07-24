# frozen_string_literal: true

FactoryGirl.define do
  factory :konduto_event do
    name  'Tia Ana no Maracanã'
    date  '2021-01-01T03:00:00Z'
    type  'show'
    subtype 'sertanejo'
    venue factory: :konduto_venue, strategy: :build
    tickets { build_list :konduto_ticket, 1 }
  end
end
