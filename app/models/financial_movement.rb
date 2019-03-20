# frozen_string_literal: true

class FinancialMovement < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  belongs_to :good
  belongs_to :kind, class_name: :FinancialMovementKind, foreign_key: :financial_movement_kind_id

  scope :initial,
        lambda {
          where(financial_movement_kind_id: FinancialMovementKind::KINDS[:initial])
        }
  scope :depreciation,
        lambda {
          where(financial_movement_kind_id: FinancialMovementKind::KINDS[:depreciation])
        }
  scope :revaluation,
        lambda {
          where(financial_movement_kind_id: FinancialMovementKind::KINDS[:revaluation])
        }

  before_validation :set_code
  before_validation :set_net_amount

  validates_presence_of :date, :amount, :depreciated_amount
  validates_numericality_of :amount, greater_than: 0, unless: :depreciation?
  validates_numericality_of :amount, less_than: 0, if: :depreciation?
  validate :date_validation, unless: :initial?
  validate :good_is_active_validation
  validates :code, uniqueness: { scope: :good_id }
  validate :depreciable_amount_validation, if: :depreciation?

  private

  def date_validation
    if good.present? && date.present?
      last_date = good.financial_movements.last.date
      if last_date > date
        errors.add(:date, :date_less_than_last_move, date: I18n.l(last_date))
      end
    end
  end

  def set_code
    self.code = 1 + (self.class.where(good_id: good_id).maximum(:code) || 0)
  end

  def good_is_active_validation
    errors.add(:base, :good_inative, good: good.code) if good.inactive?
  end

  def depreciation?
    financial_movement_kind_id == FinancialMovementKind::KINDS[:depreciation]
  end

  def revaluation?
    financial_movement_kind_id == FinancialMovementKind::KINDS[:revaluation]
  end

  def initial?
    financial_movement_kind_id == FinancialMovementKind::KINDS[:initial]
  end

  def set_net_amount
    if good.present? && amount.present?
      self.net_amount ||= if revaluation?
                            amount + good.net_amount
                          elsif initial?
                            amount
                          else
                            good.financial_movements.last.net_amount
                          end
    end
  end

  def depreciable_amount_validation
    if good.present? && amount.present?
      depreciable_amount =
        good.depreciable_amount - good.depreciated_amount
      p depreciable_amount
      if amount.abs > depreciable_amount
        errors.add(:amount,
                   :greater_than_depreciable_amount,
                   depreciable_amount: number_with_precision(depreciable_amount,
                                                             precision: 2))
      end
    end
  end
end
