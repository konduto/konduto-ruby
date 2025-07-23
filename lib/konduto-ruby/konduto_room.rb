# frozen_string_literal: true

class KondutoRoom < KondutoBase
  attributes :number, :code, :type, :check_in_date, :check_out_date,
             :number_of_guests, :board_basis
  has_many :guest, alias: :guests
end
