# frozen_string_literal: true

class GoodSubKind < ApplicationRecord
  belongs_to :good_kind
  has_many :good_categories
end
