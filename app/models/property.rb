# frozen_string_literal: true

class Property < ApplicationRecord
  has_many :departments

  scope :active, -> { where(active: true) }

  validates_presence_of :description
end
