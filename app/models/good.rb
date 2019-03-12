# frozen_string_literal: true

class Good < ApplicationRecord
  belongs_to :good_category
  belongs_to :department
  has_many :movements
  has_many :financial_movements
end
