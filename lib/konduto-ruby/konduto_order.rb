# frozen_string_literal: true

class KondutoOrder < KondutoBase
  has_many :item, alias: :shopping_cart
  has_many :payment
  has_many :destination_account, alias: :destination_accounts
  has_many :event, alias: :events
  has_many :analysis_layer, alias: :analysis_layers
  has_many :triggered_decision_list, alias: :triggered_decision_list
  has_many :triggered_rule, alias: :triggered_rules

  has_one :shipping_address, alias: :shipping
  has_one :address, alias: :billing
  has_one :customer
  has_one :seller
  has_one :travel
  has_one :device
  has_one :geolocation
  has_one :navigation
  has_one :delivery
  has_one :agent
  has_one :origin_account
  has_one :external_device
  has_one :options
  has_one :point_of_sale
  has_one :tenant
  has_one :vehicle
  has_one :hotel

  attributes :id, :visitor, :timestamp, :total_amount, :tax_amount, :currency, :installments,
             :ip, :score, :analyze, :messages_exchanged, :shipping_amount, :recurring, :risk_level,
             :sales_channel, :scheduled

  attribute first_message: :date_time, strftime_pattern: '%Y-%m-%dT%H:%M:%SZ'
  attribute purchased_at: :date_time, strftime_pattern: '%Y-%m-%dT%H:%M:%SZ'
  attribute status: :symbol
  attribute recommendation: :symbol

  validates_presence_of :id, :total_amount, :customer
end
