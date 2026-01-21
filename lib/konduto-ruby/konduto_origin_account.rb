# frozen_string_literal: true

class KondutoOriginAccount < KondutoBase
  attributes :balance, :bank_account, :bank_branch, :bank_code, :bank_name,
             :holder_name, :holder_tax_id, :id, :key_value
  attribute key_type: :symbol
  KEY_TYPE = %i[pix_cpf pix_cnpj pix_phone pix_email pix_evp p2p none].freeze
end
