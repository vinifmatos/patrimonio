# frozen_string_literal: true

FactoryBot.define do
  factory :financial_movement do
    good
    date { Faker::Date.between(good.financial_movements.last.date, good.financial_movements.last.date.next_day(15)) }
    kind { FinancialMovementKind.all.sample }
    amount do
      if kind.try(:id) == FinancialMovementKind::KINDS[:depreciation]
        Faker::Number.decimal(2, 1).to_f * -1
      else
        Faker::Number.decimal(2, 1).to_f
      end
    end
  end
end
