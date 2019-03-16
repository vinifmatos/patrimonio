# frozen_string_literal: true

class Good < ApplicationRecord
  belongs_to :good_category
  belongs_to :department
  belongs_to :good_situation
  has_many :movements, -> { order(:date, :created_at) }
  has_many :financial_movements
  after_create :create_initial_movement
  after_create :create_initial_financial_movement

  def self.t_situation(situation)
    I18n.t "activerecord.attributes.good/situations.#{situation}"
  end

  def inactive?
    good_situation_id == GoodSituation::SITUATIONS[:inactive]
  end

  private

  def create_initial_movement
    Movement.create(
      good_id: id,
      department_id: department_id,
      date: Time.now.localtime,
      movement_kind_id: MovementKind::KINDS[:incorporation]
    )
  end

  def create_initial_financial_movement
    FinancialMovement.create(
      good_id: id,
      date: Time.now.localtime,
      financial_movement_kind_id: FinancialMovementKind::KINDS[:initial],
      amount: purchase_price
    )
  end
end
