# frozen_string_literal: true

class AddMovementKindReferencesToMovement < ActiveRecord::Migration[5.2]
  def change
    add_reference :movements, :movement_kind, foreign_key: true, null: false
  end
end
