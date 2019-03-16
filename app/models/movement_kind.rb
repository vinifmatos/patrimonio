# frozen_string_literal: true

class MovementKind < ApplicationRecord
  KINDS = { incorporation: 0, borrowing: 1, transference: 2, maintence: 3, regress: 4 }.freeze

  def self.t(kind)
    I18n.t "activerecord.attributes.movement/kinds.#{kind}"
  end
end
