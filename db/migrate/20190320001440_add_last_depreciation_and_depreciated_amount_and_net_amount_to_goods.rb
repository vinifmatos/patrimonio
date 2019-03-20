# frozen_string_literal: true

class AddLastDepreciationAndDepreciatedAmountAndNetAmountToGoods < ActiveRecord::Migration[5.2]
  def change
    add_column :goods, :last_depreciation, :date
    add_column :goods, :depreciated_amount, :decimal, precision: 15, scale: 2, null: false, default: 0
    add_column :goods, :net_amount, :decimal, precision: 15, scale: 2, null: false
  end
end
