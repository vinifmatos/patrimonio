class CreateGoodSituations < ActiveRecord::Migration[5.2]
  def change
    create_table :good_situations do |t|
      t.string :description

      t.timestamps
    end
  end
end
