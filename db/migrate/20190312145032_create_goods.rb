# frozen_string_literal: true

class CreateGoods < ActiveRecord::Migration[5.2]
  def change
    create_table :goods do |t|
      t.integer :code, null: false
      t.string :description, null: false
      t.text :specification
      t.decimal :purchase_price, precision: 15, scale: 2, null: false
      t.date :purchase_date, null: false
      t.date :base_date, null: false

      t.index :code, unique: true

      t.timestamps
    end
  end
end
