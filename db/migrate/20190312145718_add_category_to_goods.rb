# frozen_string_literal: true

class AddCategoryToGoods < ActiveRecord::Migration[5.2]
  def change
    add_reference :goods, :good_category, foreign_key: true, null: false
  end
end
