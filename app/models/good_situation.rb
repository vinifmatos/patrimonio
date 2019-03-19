# frozen_string_literal: true

class GoodSituation < ApplicationRecord
  SITUATIONS = { active: 0, inactive: 1, borrowed: 2, maintenance: 3 }.freeze

  def self.t(situation)
    I18n.t "activerecord.attributes.good/situations.#{situation}"
  end

  def self.active
    where(description: :active).first
  end

  def self.inactive
    where(description: :inactive).first
  end

  def self.borrowed
    where(description: :borrowed).first
  end

  def self.maintenance
    where(description: :maintenance).first
  end
end
