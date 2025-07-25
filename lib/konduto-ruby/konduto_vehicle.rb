# frozen_string_literal: true

class KondutoVehicle < KondutoBase
  attributes :make, :model, :renavam, :registration, :vid, :type, :usage
  has_one :owner
end
