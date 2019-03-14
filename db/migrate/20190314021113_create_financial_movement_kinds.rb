class CreateFinancialMovementKinds < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_movement_kinds do |t|
      t.string :description

      t.timestamps
    end
  end
end
