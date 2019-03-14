class FinancialMovementKind < ApplicationRecord
  def self.t(kind)
    I18n.t "activerecord.attributes.financial_movement/kinds.#{kind}"
  end
end
