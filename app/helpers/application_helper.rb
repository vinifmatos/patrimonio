# frozen_string_literal: true

module ApplicationHelper
  def t_active(active)
    I18n.t "views.active.#{active}"
  end

  def form_datepicker_field(form, field, options = {}, &block)
    content_tag(:div, class: 'input-group date-input-group') do
      content = form.text_field(field,
                                value: ((I18n.l(eval("form.object.#{field}")) if eval("form.object.#{field}.present?")) if form.object.present?),
                                class: "form-control datepicker-input #{options[:class]}", required: (options[:required] || false))
      content += content_tag(:div, class: 'input-group-append') do
        button_tag(fa_icon('calendar'),
                   class: 'btn btn-outline-secondary btn-datepicker', type: 'button')
      end
      content + capture(&block) if block_given?
      content
    end
  end

  def datepicker_field(field, options = {}, &block)
    content_tag(:div, class: 'input-group date-input-group') do
      content = text_field_tag(field,
                               nil,
                               class: "form-control datepicker-input #{options[:class]}")
      content += content_tag(:div, class: 'input-group-append') do
        button_tag(fa_icon('calendar'),
                   class: 'btn btn-outline-secondary btn-datepicker', type: 'button')
      end
      content + capture(&block) if block_given?
      content
    end
  end

  def ldate(date)
    l(date) if date
  end
end
