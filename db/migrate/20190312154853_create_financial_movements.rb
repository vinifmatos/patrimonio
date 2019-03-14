# frozen_string_literal: true

class CreateFinancialMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_movements do |t|
      t.references :good, foreign_key: true
      t.date :date
      t.decimal :amount, precision: 15, scale: 2

      t.timestamps
    end
  end
end
