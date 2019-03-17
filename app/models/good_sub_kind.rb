# frozen_string_literal: true

class GoodSubKind < ApplicationRecord
  belongs_to :good_kind
  has_many :good_categories
  belongs_to :depreciation_method

  validates_presence_of :description

  before_create :set_active

  private

  def set_active
    self.active ||= true
  end
end
