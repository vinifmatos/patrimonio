class CreateGoodSubKinds < ActiveRecord::Migration[5.2]
  def change
    create_table :good_sub_kinds do |t|
      t.string :description
      t.boolean :active
      t.references :good_kind, foreign_key: true

      t.timestamps
    end
  end
end
