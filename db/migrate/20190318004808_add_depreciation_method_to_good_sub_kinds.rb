# frozen_string_literal: true

class AddDepreciationMethodToGoodSubKinds < ActiveRecord::Migration[5.2]
  def change
    add_column :good_sub_kinds, :depreciation_method, :integer, null: false
  end
end
