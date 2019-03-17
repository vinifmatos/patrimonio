# frozen_string_literal: true

class Property < ApplicationRecord
  has_many :departments

  validates_presence_of :description
end
