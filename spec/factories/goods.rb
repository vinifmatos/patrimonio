FactoryBot.define do
  factory :good do
    code { 1 }
    description { "MyString" }
    specification { "MyText" }
    situation { 1 }
    purchase_value { "9.99" }
    purchase_date { "2019-03-12" }
    base_date { "2019-03-12" }
  end
end
