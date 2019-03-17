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

  validates_presence_of :description, :code, :base_date, :purchase_date, :purchase_price
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
      errors.add(:base_date, :base_date_less_than_purchase_date, purchase_date: purchase_date) if base_date < purchase_date
    end
  end

  def active_situation_on_create_validation
    errors.add(:good_situation_id, :non_active_situation_on_create) if good_situation_id != GoodSituation::SITUATIONS[:active]
  end
end
