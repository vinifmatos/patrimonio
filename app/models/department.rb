# frozen_string_literal: true

class Department < ApplicationRecord
  belongs_to :property
  has_many :goods
end
