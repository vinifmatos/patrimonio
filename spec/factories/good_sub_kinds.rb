# frozen_string_literal: true

FactoryBot.define do
  factory :good_sub_kind do
    description { Faker::IndustrySegments.sub_sector }
    active { [true, false].sample }
    good_kind
    depreciation_method { DepreciationMethod.take }
    lifespan { rand(24..120) }
    residual_amount_rate { rand(1..10.0).round(2) }
    yearly_depreciation_rate { rand(0.1..0.2).round(4) }
  end
end
