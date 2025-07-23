# frozen_string_literal: true

class KondutoEvent < KondutoBase
  attributes :name, :subtype, :type
  validates_presence_of :name, :date, :type
  attribute date: :date_time, strftime_pattern: '%Y-%m-%dT%H:%M:%SZ'
  has_many :ticket, alias: :tickets
  has_one :venue
end
