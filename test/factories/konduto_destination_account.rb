# frozen_string_literal: true

FactoryGirl.define do
  factory :konduto_destination_account do
    amount 200.0
    bank_account '01234-5'
    bank_branch '0001'
    bank_code '17298092'
    bank_name 'Itaú BBA'
    holder_name 'José Armando'
    holder_tax_id '123.456-789-09'
    id 'Conta 003'
    key_type 'pix_evp'
    key_value '123e4567-e89b-12d3-a456-426655440000'
  end
end
