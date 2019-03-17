# frozen_string_literal: true

class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.string :description
      t.references :property, foreign_key: true, null: false
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
