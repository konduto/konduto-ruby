# frozen_string_literal: true

class KondutoHotel < KondutoBase
  attributes :name, :address1, :address2, :city, :state, :zip, :country, :category
  has_many :room, alias: :rooms
end
