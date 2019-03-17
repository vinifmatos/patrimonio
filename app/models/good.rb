# frozen_string_literal: true

class Good < ApplicationRecord
  belongs_to :good_category
  belongs_to :department
  belongs_to :good_situation
  has_many :movements, -> { order(:date, :created_at) }
  has_many :financial_movements, -> { order(:date, :created_at) }
  after_create :create_initial_movement
  after_create :create_initial_financial_movement

  before_validation :set_code
  before_validation :set_residual_amount
  before_validation :set_depreciable_amount

  validates_presence_of :description,
                        :code,
                        :base_date,
                        :purchase_date,
                        :purchase_price,
                        :residual_amount,
                        :depreciable_amount
  validates_uniqueness_of :code
  validates_numericality_of :purchase_price, greater_than: 0

  validate :base_date_validation
  validate :active_situation_on_create_validation, on: :create

  def self.t_situation(situation)
    I18n.t "activerecord.attributes.good/situations.#{situation}"
  end

  def inactive?
    good_situation_id == GoodSituation::SITUATIONS[:inactive]
  end

  def active?
    good_situation_id == GoodSituation::SITUATIONS[:active]
  end

  def borrowed?
    good_situation_id == GoodSituation::SITUATIONS[:borrowed]
  end

  def maintenance?
    good_situation_id == GoodSituation::SITUATIONS[:maintenance]
  end

  private

  def create_initial_movement
    Movement.create(
      good_id: id,
      department_id: department_id,
      date: base_date,
      movement_kind_id: MovementKind::KINDS[:incorporation]
    )
  end

  def create_initial_financial_movement
    FinancialMovement.create(
      good_id: id,
      date: base_date,
      financial_movement_kind_id: FinancialMovementKind::KINDS[:initial],
      amount: purchase_price
    )
  end

  def set_code
    self.code ||= 1 + (Good.maximum(:code) || 0)
  end

  def base_date_validation
    if base_date.present? && purchase_date.present?
      if base_date < purchase_date
        errors.add(:base_date,
                   :base_date_less_than_purchase_date,
                   purchase_date: purchase_date)
      end
    end
  end

  def active_situation_on_create_validation
    if good_situation_id != GoodSituation::SITUATIONS[:active]
      errors.add(:good_situation_id, :non_active_situation_on_create)
    end
  end

  def set_residual_amount
    if purchase_price.present? && good_category.present?
      self.residual_amount ||= purchase_price * (
        good_category.good_sub_kind.residual_amount_rate / 100)
    end
  end

  def set_depreciable_amount
    if purchase_price.present? && residual_amount.present?
      self.depreciable_amount ||= purchase_price - residual_amount
    end
  end
end
