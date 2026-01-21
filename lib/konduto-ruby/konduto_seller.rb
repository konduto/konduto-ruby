# frozen_string_literal: true

class KondutoSeller < KondutoBase
  attributes :id, :name
  attribute created_at: :date
end
