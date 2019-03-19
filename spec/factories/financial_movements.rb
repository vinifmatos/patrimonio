# frozen_string_literal: true

FactoryBot.define do
  factory :financial_movement do
    good
    date do
      Faker::Date.between(good.financial_movements.last.date,
                          good.financial_movements.last.date.next_day(15))
    end

    factory :initial_financial_movement do
      kind { FinancialMovementKind.initial }
      amount { Faker::Number.decimal(2, 1).to_f }
    end

    factory :revaluation_financial_movement do
      kind { FinancialMovementKind.revaluation }
      amount { Faker::Number.decimal(2, 1).to_f }
    end

    factory :depreciation_financial_movement do
      kind { FinancialMovementKind.depreciation }
      amount { Faker::Number.decimal(2, 1).to_f * -1 }
    end
  end
end
