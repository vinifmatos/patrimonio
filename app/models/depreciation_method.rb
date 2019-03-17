# frozen_string_literal: true

class DepreciationMethod < ApplicationRecord
  METHODS = { constant_quotas: 0, digits_sum: 1, unitis_produced: 2 }.freeze

  has_many :good_sub_kinds
end
