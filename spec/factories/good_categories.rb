# frozen_string_literal: true

FactoryBot.define do
  factory :good_category, aliases: [:category] do
    description { Faker::IndustrySegments.industry }
    active { [true, false].sample }
    sub_kind { FactoryBot.create(:sub_kind) }
  end
end
