# frozen_string_literal: true

class FinancialMovement < ApplicationRecord
  enum kind: %i[initial revaluation depreciation]
  belongs_to :good
end
