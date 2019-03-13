# frozen_string_literal: true

FactoryBot.define do
  factory :movement do
    good
    department
    date { Faker::Date.between(300.days.ago, Date.today) }
    kind { Movement.kinds.values.sample }
  end
end
