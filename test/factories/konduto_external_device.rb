# frozen_string_literal: true

FactoryGirl.define do
  factory :konduto_external_device do
    fingerprint '51asd1asd445asd85d4g98s'
    provider 'SDK'
    category 'Mobile'
    model 'Galaxy S22 Ultra'
    platform 'Android'
    manufacturer 'Samsung '
    os 'Android 12 Samsung One UI 4.1'
    browser 'Chrome 104.0.5112.79'
    language 'pt-br'
  end
end
