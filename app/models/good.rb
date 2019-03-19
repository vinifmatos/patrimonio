# frozen_string_literal: true

class Good < ApplicationRecord
  include Depreciation

  belongs_to :category, class_name: :GoodCategory, foreign_key: :good_category_id
  belongs_to :department
  belongs_to :situation, class_name: :GoodSituation, foreign_key: :good_situation_id
  has_many :movements, -> { order(:date, :created_at) }
  has_many :financial_movements, -> { order(:date, :created_at) }
  after_create :create_initial_movement
  after_create :create_initial_financial_movement

  before_validation :set_code
  before_validation :set_residual_amount
  before_validation :set_depreciable_amount
  before_validation :set_depreciation_method

  validates_presence_of :description,
                        :code,
                        :base_date,
                        :purchase_date,
                        :purchase_price,
                        :residual_amount,
                        :depreciable_amount,
                        :depreciation_method
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

  def depreciated_amount
    financial_movements.last.depreciated_amount
  end

  def net_amount
    financial_movements.last.net_amount
  end

  def last_financial_movement
    financial_movements.last
  end

  def deactivation
    movements.deactivation.last
  end

  def yearly_depreciation_rate
    category.sub_kind.yearly_depreciation_rate
  end

  def lifespan
    category.sub_kind.lifespan
  end

  def last_depreciation
    financial_movements.depreciation.last
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
    if purchase_price.present? && category.present?
      self.residual_amount ||= purchase_price *
                               category.sub_kind.residual_amount_rate
    end
  end

  def set_depreciable_amount
    if purchase_price.present? && residual_amount.present?
      self.depreciable_amount ||= purchase_price - residual_amount
    end
  end

  def set_depreciation_method
    self.depreciation_method ||= category.sub_kind.depreciation_method if category.try(:sub_kind).present?
  end
end
