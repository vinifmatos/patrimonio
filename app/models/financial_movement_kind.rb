# frozen_string_literal: true

class FinancialMovementKind < ApplicationRecord
  KINDS = { initial: 0, revaluation: 1, depreciation: 2 }.freeze

  def self.t(kind)
    I18n.t "activerecord.attributes.financial_movement/kinds.#{kind}"
  end

  def self.depreciation
    where(description: :depreciation).first
  end

  def self.revaluation
    where(description: :revaluation).first
  end

  def self.initial
    where(description: :initial).first
  end
end
