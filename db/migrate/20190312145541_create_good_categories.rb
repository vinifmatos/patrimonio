# frozen_string_literal: true

class CreateGoodCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :good_categories do |t|
      t.string :description
      t.boolean :active, null: false, default: true
      t.references :good_sub_kind, foreign_key: true, null: false

      t.timestamps
    end
  end
end
