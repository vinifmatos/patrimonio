# frozen_string_literal: true

class AddGoodSituationReferencesToGoods < ActiveRecord::Migration[5.2]
  def change
    add_reference :goods, :good_situation, foreign_key: true, null: false
  end
end
