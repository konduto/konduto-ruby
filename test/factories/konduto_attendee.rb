# frozen_string_literal: true

FactoryGirl.define do
  factory :konduto_attendee do
    document '123456789'
    document_type :cpf
    dob '1990-10-28'
  end
end
