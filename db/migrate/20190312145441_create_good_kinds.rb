class CreateGoodKinds < ActiveRecord::Migration[5.2]
  def change
    create_table :good_kinds do |t|
      t.string :description
      t.boolean :active

      t.timestamps
    end
  end
end
