# frozen_string_literal: true

class FinancialMovement < ApplicationRecord
  belongs_to :good
  belongs_to :financial_movement_kind

  before_validation :set_code

  validates_presence_of :date, :amount
  validates_numericality_of :amount, greater_than: 0, unless: :depreciation?
  validates_numericality_of :amount, less_than: 0, if: :depreciation?
  validate :date_validation
  validate :good_is_active_validation
  validates :code, uniqueness: { scope: :good_id }

  private

  def date_validation
    if good.present? && date.present? && financial_movement_kind_id != FinancialMovementKind::KINDS[:initial]
      last_date = good.financial_movements.last.date
      if last_date > date
        errors.add(:date, :date_less_than_last_move, date: last_date)
      end
    end
  end

  def set_code
    self.code = 1 + (FinancialMovement.where(good_id: good_id).maximum(:code) || 0)
  end

  def good_is_active_validation
    errors.add(:base, :good_inative, good: good.code) if good.inactive?
  end

  def depreciation?
    financial_movement_kind_id == FinancialMovementKind::KINDS[:depreciation]
  end
end
