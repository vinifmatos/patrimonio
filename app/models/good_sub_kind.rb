# frozen_string_literal: true

class GoodSubKind < ApplicationRecord
  belongs_to :kind, class_name: :GoodKind, foreign_key: :good_kind_id
  has_many :categories, foreign_key: :good_sub_kind_id, class_name: 'GoodCategory'

  validates_presence_of :description, :lifespan, :residual_amount_rate, :yearly_depreciation_rate, :depreciation_method
  validates_numericality_of :lifespan, :residual_amount_rate, :yearly_depreciation_rate, greater_than: 0
end
