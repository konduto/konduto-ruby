# frozen_string_literal: true

class KondutoOrderStatus < KondutoBase
  attributes :status, :comments

  def self.allowed_status
    %w[APPROVED DECLINED NOT_AUTHORIZED CANCELED FRAUD]
  end
end
