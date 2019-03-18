# frozen_string_literal: true

class GoodCategory < ApplicationRecord
  belongs_to :sub_kind, class_name: :GoodSubKind, foreign_key: :good_sub_kind_id
  has_many :goods

  validates_presence_of :description
end
