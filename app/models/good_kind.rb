# frozen_string_literal: true

class GoodKind < ApplicationRecord
  has_many :sub_kinds, foreign_key: :good_kind_id, class_name: 'GoodSubKind'

  scope :active, -> { where(active: true) }

  validates_presence_of :description
end
