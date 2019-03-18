# frozen_string_literal: true

FactoryBot.define do
  factory :good_sub_kind, aliases: [:sub_kind] do
    description { Faker::IndustrySegments.sub_sector }
    active { [true, false].sample }
    kind { FactoryBot.create(:good_kind) }
    lifespan { rand(24..120) }
    residual_amount_rate { rand(1..10.0).round(2) }
    yearly_depreciation_rate { rand(0.1..0.2).round(4) }
    depreciation_method { Depreciation::METHODS[Depreciation::METHODS.keys.sample] }
  end
end
