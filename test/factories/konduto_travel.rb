# frozen_string_literal: true

FactoryGirl.define do
  factory :konduto_travel do
    type :flight
    expiration_date '2022-05-12T15:25:30Z'
    departure factory: %i[konduto_flight_leg departure_flight], strategy: :build
    add_attribute(:return) { build :konduto_flight_leg, :return_flight }
    passengers { build_list :konduto_passenger, 1, :fixed_complete }
  end
end
