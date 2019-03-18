# frozen_string_literal: true

class Movement < ApplicationRecord
  belongs_to :good
  belongs_to :department
  belongs_to :kind, class_name: :MovementKind, foreign_key: :movement_kind_id

  scope :deactivation, -> { where(movement_kind_id: MovementKind::KINDS[:deactivation]) }

  validates_presence_of :date, :department_id, :movement_kind_id, :good_id
  validates :code, uniqueness: { scope: :good_id }
  validate :validate_date
  validate :validate_department
  validate :good_is_active
  validate :good_is_borrowed
  validate :good_in_maintenance

  before_validation :set_code

  private

  def validate_date
    last_date = Movement.where(good_id: good_id).maximum(:date)
    (errors.add(:date, :date_less_then, date: I18n.l(last_date)) if date < last_date) unless date.nil? || last_date.nil?
  end

  def good_is_active
    if good.present?
      errors.add(:base, :good_inactive, good: good.code) if good.inactive?
    end
  end

  def validate_department
    last_movement = Movement.where(good_id: good_id).order(:date, :created_at).last
    if department.present?
      if movement_kind_id == MovementKind::KINDS[:transference] &&
         last_movement.department_id == department_id
        errors.add(:department_id, :move_to_same_department, department: department.description)
      end
    end
  end

  def set_code
    self.code ||= 1 + (Movement.where(good_id: good_id).maximum(:code) || 0)
  end

  def good_is_borrowed
    if good.present?
      if good.borrowed? && movement_kind_id != MovementKind::KINDS[:regress]
        errors.add(
          :movement_kind_id,
          :move_borrowed_good,
          good: good.description
        )
      end
    end
  end

  def good_in_maintenance
    if good.present?
      if good.maintenance? && movement_kind_id != MovementKind::KINDS[:regress]
        errors.add(
          :movement_kind_id,
          :move_borrowed_good,
          good: good.description
        )
      end
    end
  end
end
