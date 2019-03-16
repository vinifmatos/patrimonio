# frozen_string_literal: true


FactoryBot.define do
  factory :department do
    description { Faker::Color.color_name }
    property
    active { [true, false].sample }
  end
end
