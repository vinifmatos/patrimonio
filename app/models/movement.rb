# frozen_string_literal: true

class Movement < ApplicationRecord
  belongs_to :good
  belongs_to :department
  belongs_to :movement_kind

  before_create :set_code

  def set_code
    self.code = 1 + (Movement.where(good_id: good_id).maximum(:code) || 0)
  end
end
