# frozen_string_literal: true

require 'date'

FactoryBot.define do
  factory :konduto_order do
    id { '1' }
    total_amount { 120.5 }

    customer factory: :konduto_customer, strategy: :build

    trait :complete do
      analyze { true }
      visitor { 'a9031kdlas' }
      currency { 'USD' }
      installments { 1 }
      ip { '192.168.0.1' }
      shipping_amount { 5.0 }
      tax_amount { 3.0 }
      timestamp { 123_123_123_123 }
      status { :approved }
      recommendation { :approve }
      first_message { DateTime.new(2015, 6, 9, 18, 27, 1) }
      purchased_at { DateTime.new(2015, 6, 9, 18, 27, 1) }
      messages_exchanged { 2 }
      recurring { true }
      risk_level { 'low' }
      sales_channel { 'e-commerce' }
      scheduled { false }
      customer factory: %i[konduto_customer complete], strategy: :build
      shipping factory: :konduto_address, strategy: :build
      billing factory: :konduto_address, strategy: :build
      geolocation factory: :konduto_geolocation, strategy: :build
      payment { build_list :konduto_payment, 1, :credit_card }
      shopping_cart { [build(:konduto_item, :green_shirt), build(:konduto_item, :yellow_socks)] }
      travel factory: :konduto_travel, strategy: :build
      seller factory: :konduto_seller, strategy: :build
      delivery factory: :konduto_delivery, strategy: :build
      agent factory: :konduto_agent, strategy: :build
      origin_account factory: :konduto_origin_account, strategy: :build
      destination_accounts { build_list :konduto_destination_account, 1 }
      events { build_list :konduto_event, 1 }
      external_device factory: :konduto_external_device, strategy: :build
      hotel factory: :konduto_hotel, strategy: :build
      options factory: :konduto_options, strategy: :build
      point_of_sale factory: :konduto_point_of_sale, strategy: :build
      tenant factory: :konduto_tenant, strategy: :build
      vehicle factory: :konduto_vehicle, strategy: :build
      analysis_layers { build_list :konduto_analysis_layer, 1 }
      triggered_decision_list { build_list :konduto_triggered_decision_list, 1 }
      triggered_rules { build_list :konduto_triggered_rule, 1 }
    end
  end
end
