# frozen_string_literal: true

class KondutoAgent < KondutoBase
  attributes :id, :category, :login, :name, :tax_id
  attribute created_at: :date
  attribute dob: :date

  validates_presence_of :id, :name
end
