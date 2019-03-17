# frozen_string_literal: true

class AddDepreciationParamtersToGoodSubKinds < ActiveRecord::Migration[5.2]
  def change
    add_column :good_sub_kinds, :lifespan, :integer, null: false
    add_column :good_sub_kinds, :residual_amount_rate, :float, null: false
    add_column :good_sub_kinds, :yearly_depreciation_rate, :float, null: false
  end
end
