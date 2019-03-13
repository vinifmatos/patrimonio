# frozen_string_literal: true

class Good < ApplicationRecord
  enum situation: %i[active inactive borrowed maintenance]
  belongs_to :good_category
  belongs_to :department
  has_many :movements
  has_many :financial_movements
  after_create :create_initial_movement
  after_create :create_initial_financial_movement

  def create_initial_movement
    Movement.create(
      good_id: id,
      department_id: department_id,
      date: Time.now,
      kind: :initial
    )
  end

  def create_initial_financial_movement
    FinancialMovement.create(
      good_id: id,
      date: Time.now,
      kind: :initial,
      amount: purchase_price
    )
  end
end
