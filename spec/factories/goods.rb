# frozen_string_literal: true

FactoryBot.define do
  factory :good do
    sequence(:code) { |n| n }
    description { Faker::Commerce.product_name }
    specification { Faker::Lorem.paragraph_by_chars(256, false) }
    purchase_price { Faker::Commerce.price }
    purchase_date { Faker::Date.between(60.days.ago, Date.today) }
    base_date { Faker::Date.between(purchase_date, purchase_date.next_day(15)) }
    situation { Good.situations.values.sample }

    factory :good_with_department do
      department
    end

    factory :good_with_category do
      good_category
    end

    factory :good_full do
      department
      good_category
    end
  end
end
