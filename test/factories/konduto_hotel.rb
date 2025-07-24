# frozen_string_literal: true

FactoryGirl.define do
  factory :konduto_hotel do
    name 'Hotel Konduto'
    address1 'Rod Três, 46'
    address2 'Vidinha'
    city 'Pouso Alto'
    state 'MG'
    zip '12345-123'
    country 'BR'
    category 'Gold'
    rooms { build_list :konduto_room, 1 }
  end
end
