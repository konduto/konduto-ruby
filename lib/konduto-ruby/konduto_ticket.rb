# frozen_string_literal: true

class KondutoTicket < KondutoBase
  attributes :id, :category, :section, :premium
  validates_presence_of :category, :premium
  has_one :attendee
end
