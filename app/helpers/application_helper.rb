# frozen_string_literal: true

module ApplicationHelper
  def t_active(active)
    I18n.t "active.#{active}"
  end
end
