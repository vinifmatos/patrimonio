# frozen_string_literal: true

class FinancialMovement < ApplicationRecord
  belongs_to :good
  belongs_to :financial_movement_kind
  before_create :set_code

  def set_code
    self.code = 1 + (FinancialMovement.where(good_id: good_id).maximum(:code) || 0)
  end
end
