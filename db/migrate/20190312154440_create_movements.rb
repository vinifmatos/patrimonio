# frozen_string_literal: true

class CreateMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :movements do |t|
      t.references :good, foreign_key: true
      t.references :department, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
