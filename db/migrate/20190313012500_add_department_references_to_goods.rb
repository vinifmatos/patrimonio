class AddDepartmentReferencesToGoods < ActiveRecord::Migration[5.2]
  def change
    add_reference :goods, :department, foreign_key: true
  end
end
