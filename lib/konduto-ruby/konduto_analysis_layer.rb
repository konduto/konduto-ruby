# frozen_string_literal: true

class KondutoAnalysisLayer < KondutoBase
  attributes :recommendation, :original_recommendation,
             :is_exploring, :analysis_type, :score
end
