# frozen_string_literal: true

FactoryBot.define do
  factory :konduto_address do
    name { 'Konduto' }
    address1 { 'R. Teodoro Sampaio, 2393' }
    address2 { 'CJ. 111' }
    zip { '05406-200' }
    city { 'São Paulo' }
    state { 'SP' }
    country { 'BR' }
    lat { -23.565779450573725 }
    lon { -46.691031683668946 }
  end
end
