class CreateFinancialMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_movements do |t|
      t.references :good, foreign_key: true
      t.date :date
      t.integer :kind
      t.decimal :amount, scale: 2

      t.timestamps
    end
  end
end
