# frozen_string_literal: true

FactoryGirl.define do
  factory :konduto_origin_account do
    balance 250.0
    bank_account '123123'
    bank_branch '0001'
    bank_code '00000000'
    bank_name 'Banco do Brasil'
    holder_name 'Alberto Armando'
    holder_tax_id '123.456.789-09'
    id 'ABC123DEF'
    key_type 'pix_phone'
    key_value '+5511912341234'
  end
end
