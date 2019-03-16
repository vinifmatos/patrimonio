# frozen_string_literal: true

class Movement < ApplicationRecord
  belongs_to :good
  belongs_to :department
  belongs_to :movement_kind

  validates_presence_of :date, :department_id, :movement_kind_id, :good_id
  validates :code, uniqueness: { scope: :good_id }
  validate :validate_date
  validate :validate_department
  validate :validate_good_active

  before_validation :set_code

  def set_code
    self.code ||= 1 + (Movement.where(good_id: good_id).maximum(:code) || 0)
  end

  def validate_date
    last_date = Movement.where(good_id: good_id).maximum(:date)
    (errors.add(:date, :date_less_then, date: I18n.l(last_date)) if date < last_date) unless date.nil? || last_date.nil?
  end

  def validate_good_active
    if good.present?
      errors.add(:base, :good_inative, good: good.description) if good.inactive?
    end
  end

  def validate_department
    last_movement = Movement.where(good_id: good_id).order(:date, :created_at).last
    if department.present?
      if movement_kind_id == MovementKind::KINDS[:transference] && last_movement.department_id == department_id
        errors.add(:department_id, :move_to_same_department, department: department.description)
      end
    end
  end
end
