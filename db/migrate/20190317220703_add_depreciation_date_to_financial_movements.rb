class AddDepreciationDateToFinancialMovements < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_movements, :depreciation_date, :date
  end
end
