# frozen_string_literal: true

module ApplicationHelper
  def t_active(active)
    I18n.t "views.active.#{active}"
  end

  def datepicker_field(form, field, options = {}, &block)
    content_tag(:div, class: 'input-group date-input-group') do
      content = form.text_field(field,
                                value: (I18n.l(eval("form.object.#{field}")) if eval("form.object.#{field}.present?")),
                                class: "form-control datepicker-input #{options[:class]}", required: (options[:required] || false)) +
                content_tag(:div, class: 'input-group-append') do
                  button_tag(fa_icon('calendar'),
                             class: 'btn btn-outline-secondary btn-datepicker', type: 'button')
                end
      content + capture(&block) if block_given?
    end
  end
end
