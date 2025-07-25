# frozen_string_literal: true

class KondutoCustomer < KondutoBase
  attributes :id, :name, :email, :new?, :vip?, :phone1, :phone2, :tax_id,
             :document_type, :type, :risk_level, :risk_score, :mother_name
  attribute created_at: :date
  attribute dob: :date

  validates_presence_of :id, :name, :email
end
