# frozen_string_literal: true

class MovementKind < ApplicationRecord
  def self.t(kind)
    I18n.t "activerecord.attributes.movement/kinds.#{kind}"
  end
end
