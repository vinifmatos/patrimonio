# frozen_string_literal: true

class Property < ApplicationRecord
  belongs_to :good, optional: true
  has_many :departments

  validates_presence_of :description

  before_create :set_active

  private

  def set_active
    self.active ||= true
  end
end
