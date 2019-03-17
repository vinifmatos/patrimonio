# frozen_string_literal: true

class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.string :description
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
