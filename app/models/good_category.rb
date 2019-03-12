# frozen_string_literal: true

class GoodCategory < ApplicationRecord
  belongs_to :good_sub_kind
  has_many :goods
end
