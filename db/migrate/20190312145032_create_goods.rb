# frozen_string_literal: true

class CreateGoods < ActiveRecord::Migration[5.2]
  def change
    create_table :goods do |t|
      t.integer :code
      t.string :description
      t.text :specification
      t.integer :situation
      t.decimal :purchase_price, precision: 15, scale: 2
      t.date :purchase_date
      t.date :base_date

      t.timestamps
    end
  end
end
