# frozen_string_literal: true

FactoryGirl.define do
  factory :konduto_flight_leg do
    trait :departure_flight do
      origin_airport 'CGH'
      origin_city 'São Paulo'
      destination_airport 'SDU'
      destination_city 'Rio de Janeiro'
      klass :economy
      number_of_connections 0
      date '2015-05-07'
      fare_basis 'Y'
      company 'Gol'
    end

    trait :return_flight do
      origin_airport 'SDU'
      origin_city 'Rio de Janeiro'
      destination_airport 'CGH'
      destination_city 'São Paulo'
      klass :economy
      number_of_connections 0
      date '2015-05-07'
      fare_basis 'Y'
      company 'Gol'
    end
  end
end
