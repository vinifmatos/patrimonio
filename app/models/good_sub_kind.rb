# frozen_string_literal: true

class GoodSubKind < ApplicationRecord
  belongs_to :good_kind
  has_many :good_categories
  belongs_to :depreciation_method

  validates_presence_of :description, :lifespan, :residual_amount_rate, :yearly_depreciation_rate
  validates_numericality_of :lifespan, :residual_amount_rate, :yearly_depreciation_rate, greater_than: 0
end
