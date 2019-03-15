# frozen_string_literal: true

module ApplicationHelper
  def t_active(active)
    I18n.t "active.#{active}"
  end

  def datepicker_field(form, field)
    content_tag(:div, class: 'input-group date-input-group') do
      form.text_field(field,
                      value: (I18n.l(eval("form.object.#{field}")) if eval("form.object.#{field}.present?")),
                      class: 'form-control datepicker') +
        content_tag(:div, class: 'input-group-append') do
          button_tag(fa_icon('calendar'),
                     id: 'btn-datepicker',
                     class: 'btn btn-outline-secondary', type: 'button')
        end
    end
  end
end
