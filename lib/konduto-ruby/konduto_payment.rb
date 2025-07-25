# frozen_string_literal: true

class KondutoPayment < KondutoBase
  attributes :expiration_date, :bin, :last4, :amount, :sha1, :cvv_result,
             :avs_result, :number_of_retries, :tax_id, :description
  attribute type: :symbol
  attribute status: :symbol

  TYPE_PAYMENT = %i[credit boleto debit transfer voucher].freeze
  TYPE_STATUS = %i[approved declined pending].freeze
end
