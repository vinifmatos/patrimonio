# frozen_string_literal: true

class AddDepreciationParamtersToGoodSubKinds < ActiveRecord::Migration[5.2]
  def change
    add_column :good_sub_kinds, :lifespan, :integer
    add_column :good_sub_kinds, :residual_amount_rate, :float
    add_column :good_sub_kinds, :yearly_depreciation_rate, :float
  end
end
