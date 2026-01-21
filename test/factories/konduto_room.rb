# frozen_string_literal: true

FactoryBot.define do
  factory :konduto_room do
    number { '201A' }
    code { '25487' }
    type { 'A1' }
    check_in_date  { '2022-02-14' }
    check_out_date { '2022-03-01' }
    number_of_guests { 1 }
    board_basis { 'economy' }
    guests { build_list :konduto_guest, 1 }
  end
end
