# frozen_string_literal: true

class Property < ApplicationRecord
  belongs_to :good, optional: true
  has_many :departments
end
