# frozen_string_literal: true

FactoryBot.define do
  factory :good_sub_kind do
    description { Faker::IndustrySegments.sub_sector }
    active { [true, false].sample }
    good_kind
  end
end
