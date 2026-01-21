# frozen_string_literal: true

FactoryBot.define do
  factory :konduto_guest do
    name { 'João Silva' }
    document { '12345678990' }
    document_type { 'cpf' }
    dob { '1985-05-08' }
    nationality { 'BR' }
  end
end
