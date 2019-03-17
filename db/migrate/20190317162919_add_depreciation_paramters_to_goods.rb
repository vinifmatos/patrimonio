# frozen_string_literal: true

class AddDepreciationParamtersToGoods < ActiveRecord::Migration[5.2]
  def change
    add_column :goods, :residual_amount, :decimal, precision: 15, scale: 2, null: false
    add_column :goods, :depreciable_amount, :decimal, precision: 15, scale: 2, null: false
  end
end
