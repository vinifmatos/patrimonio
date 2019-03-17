# frozen_string_literal: true

FactoryBot.define do
  factory :financial_movement do
    good
    date { Faker::Date.between(good.financial_movements.last.date, good.financial_movements.last.date.next_day(15)) }
    financial_movement_kind { FinancialMovementKind.all.sample }
    amount { Faker::Number.decimal(2, 1) }
  end
end
