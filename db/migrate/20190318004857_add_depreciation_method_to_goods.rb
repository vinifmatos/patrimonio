# frozen_string_literal: true

class AddDepreciationMethodToGoods < ActiveRecord::Migration[5.2]
  def change
    add_column :goods, :depreciation_method, :integer, null: false
  end
end
