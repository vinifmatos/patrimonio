# frozen_string_literal: true

FactoryBot.define do
  factory :financial_movement do
    good
    date { Faker::Date.between(300.days.ago, Date.today) }
    kind { FinancialMovement.kinds.values.sample }
    amount { Faker::Number.decimal(2, 1) }
  end
end
