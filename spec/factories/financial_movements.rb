# frozen_string_literal: true

FactoryBot.define do
  factory :financial_movement do
    good
    date { Faker::Date.between(300.days.ago, Date.today) }
    financial_movement_kind { FinancialMovementKind.all.sample }
    amount { Faker::Number.decimal(2, 1) }
  end
end
