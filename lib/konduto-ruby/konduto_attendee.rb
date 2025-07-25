# frozen_string_literal: true

class KondutoAttendee < KondutoBase
  attributes :name, :document
  attribute document_type: :symbol
  attribute dob: :date
  validates_presence_of :document
  DOCUMENT_TYPE = %i[cpf cnpj rg passport other].freeze
end
