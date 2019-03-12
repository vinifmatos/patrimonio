# frozen_string_literal: true

class GoodKind < ApplicationRecord
  has_many :good_sub_kinds
end
