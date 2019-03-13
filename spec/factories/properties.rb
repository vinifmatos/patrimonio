# frozen_string_literal: true

FactoryBot.define do
  factory :property do
    description { Faker::Address.city }
    active { [false, true].sample }
  end
end
