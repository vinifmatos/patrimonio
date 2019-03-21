# frozen_string_literal: true

FactoryBot.define do
  factory :good_kind, aliases: [:kind] do
    description { Faker::IndustrySegments.sector }
    active { [true, false].sample }
  end
end
