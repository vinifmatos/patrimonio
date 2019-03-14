class AddCodeToFinancialMovements < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_movements, :code, :integer
  end
end
