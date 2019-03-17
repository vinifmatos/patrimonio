# frozen_string_literal: true

class AddCodeToFinancialMovements < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_movements, :code, :integer, null: false

    add_index :financial_movements, %i[good_id code], unique: true
  end
end
