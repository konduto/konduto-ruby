# frozen_string_literal: true

FactoryBot.define do
  factory :konduto_payment do
    trait :credit_card do
      bin { '123456' }
      expiration_date { '012014' }
      last4 { '1234' }
      status { :approved }
      type { :credit }
      amount { 100.65 }
      sha1 { '1a2b3c4d5e6f7A8B9C10D11E12F1a2b3c4d5e6f7' }
      cvv_result { 'valid' }
      avs_result { 'ok' }
      number_of_retries { 1 }
      tax_id { '12345678990' }
    end

    trait :voucher do
      type { 'voucher' }
      amount { 10.0 }
      description { 'Desconto de 10%' }
    end
  end
end
