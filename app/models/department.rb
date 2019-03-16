# frozen_string_literal: true

class Department < ApplicationRecord
  belongs_to :property
  has_many :goods

  validates_presence_of :description

  before_save :set_active

  private

  def set_active
    self.active ||= true
  end
end
