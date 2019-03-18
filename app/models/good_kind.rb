# frozen_string_literal: true

class GoodKind < ApplicationRecord
  has_many :good_sub_kinds, as: :sub_kinds

  validates_presence_of :description
end
