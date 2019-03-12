class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.string :description
      t.references :property, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
