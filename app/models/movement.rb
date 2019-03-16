# frozen_string_literal: true

class Movement < ApplicationRecord
  belongs_to :good
  belongs_to :department
  belongs_to :movement_kind

  validates_presence_of :date, :department, :movement_kind, :good
  validates :code, uniqueness: { scope: :good_id }
  validate :validate_date

  before_validation :set_code

  def set_code
    self.code ||= 1 + (Movement.where(good_id: good_id).maximum(:code) || 0)
  end

  def validate_date
    last_date = Movement.where(good_id: good_id).maximum(:date)
    (errors.add(:date, :date_less_then, date: I18n.l(last_date)) if date < last_date) unless date.nil? || last_date.nil?
  end
end
