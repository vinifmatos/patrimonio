# frozen_string_literal: true

class CreateGoodKinds < ActiveRecord::Migration[5.2]
  def change
    create_table :good_kinds do |t|
      t.string :description
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
