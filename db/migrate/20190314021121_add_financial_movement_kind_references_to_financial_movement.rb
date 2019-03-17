# frozen_string_literal: true

class AddFinancialMovementKindReferencesToFinancialMovement < ActiveRecord::Migration[5.2]
  def change
    add_reference :financial_movements, :financial_movement_kind, foreign_key: true, null: false
  end
end
