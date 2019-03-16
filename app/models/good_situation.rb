# frozen_string_literal: true

class GoodSituation < ApplicationRecord
  SITUATIONS = { active: 0, inactive: 1, borrowed: 2, maintenance: 3 }.freeze

  def self.t(situation)
    I18n.t "activerecord.attributes.good/situations.#{situation}"
  end
end
