# frozen_string_literal: true

class KondutoAddress < KondutoBase
  attributes :name, :address1, :address2, :zip, :city, :state, :country, :lat, :lon
end
