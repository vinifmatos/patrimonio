# frozen_string_literal: true

class GoodCategory < ApplicationRecord
  belongs_to :good_sub_kind
  has_many :goods

  validates_presence_of :description

  before_create :set_active

  private

  def set_active
    self.active ||= true
  end
end
