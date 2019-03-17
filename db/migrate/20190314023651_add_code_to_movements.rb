# frozen_string_literal: true

class AddCodeToMovements < ActiveRecord::Migration[5.2]
  def change
    add_column :movements, :code, :integer, null: false

    add_index :movements, %i[good_id code], unique: true
  end
end
