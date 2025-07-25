# frozen_string_literal: true

FactoryBot.define do
  factory :konduto_vehicle do
    make { 'Bentley' }
    model { 'Bacalar' }
    renavam { '12312312312' }
    registration { 'ABC1234' }
    vid { '5GZCZ43D13S812715' }
    type { 'car' }
    usage { 'private' }
    owner factory: :konduto_owner, strategy: :build
  end
end
