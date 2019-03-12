FactoryBot.define do
  factory :good_sub_kind do
    description { "MyString" }
    active { false }
    good_kind { nil }
  end
end
