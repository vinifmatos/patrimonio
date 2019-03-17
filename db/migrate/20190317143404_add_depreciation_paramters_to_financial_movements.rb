# frozen_string_literal: true

class AddDepreciationParamtersToFinancialMovements < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_movements, :depreciated_amount, :decimal, precision: 15, scale: 2, default: 0, null: false
    add_column :financial_movements, :net_amount, :decimal, precision: 15, scale: 2, null: false
  end
end
