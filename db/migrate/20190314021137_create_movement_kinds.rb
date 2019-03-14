class CreateMovementKinds < ActiveRecord::Migration[5.2]
  def change
    create_table :movement_kinds do |t|
      t.string :description

      t.timestamps
    end
  end
end
