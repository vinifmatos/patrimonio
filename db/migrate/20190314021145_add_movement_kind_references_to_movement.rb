class AddMovementKindReferencesToMovement < ActiveRecord::Migration[5.2]
  def change
    add_reference :movements, :movement_kind, foreign_key: true
  end
end
