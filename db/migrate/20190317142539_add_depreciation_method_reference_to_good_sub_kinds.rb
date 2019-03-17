class AddDepreciationMethodReferenceToGoodSubKinds < ActiveRecord::Migration[5.2]
  def change
    add_reference :good_sub_kinds, :depreciation_method, foreign_key: true
  end
end
