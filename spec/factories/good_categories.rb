# frozen_string_literal: true

FactoryBot.define do
  factory :good_category do
    description { Faker::IndustrySegments.industry }
    active { [true, false].sample }
    good_sub_kind
  end
end
