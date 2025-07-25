# frozen_string_literal: true

FactoryBot.define do
  factory :konduto_ticket do
    id { '123456' }
    category { 'regular' }
    premium { true }
    section { 'Pista Premium' }
    attendee factory: :konduto_attendee, strategy: :build
  end
end
