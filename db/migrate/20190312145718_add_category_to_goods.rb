class AddCategoryToGoods < ActiveRecord::Migration[5.2]
  def change
    add_reference :goods, :category, foreign_key: true
  end
end
