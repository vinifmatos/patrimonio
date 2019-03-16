# frozen_string_literal: true

class GoodKind < ApplicationRecord
  has_many :good_sub_kinds

  validates_presence_of :description

  before_create :set_active

  private

  def set_active
    self.active ||= true
  end
end
