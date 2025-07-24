# frozen_string_literal: true

class KondutoVenue < KondutoBase
  attributes :address, :capacity, :city, :country, :name, :state
  validates(:country) do |attr|
    attr.match(/[a-zA-Z]{2}/)
  end
end
