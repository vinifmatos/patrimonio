FactoryBot.define do
  factory :financial_movement do
    good { nil }
    date { "2019-03-12" }
    kind { 1 }
    amount { "9.99" }
  end
end
