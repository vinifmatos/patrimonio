class AddGoodSituationReferencesToGoods < ActiveRecord::Migration[5.2]
  def change
    add_reference :goods, :good_situation, foreign_key: true
  end
end
