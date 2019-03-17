# frozen_string_literal: true

FactoryBot.define do
  factory :good do
    description { Faker::Commerce.product_name }
    specification { Faker::Lorem.paragraph_by_chars(256, false) }
    purchase_price { Faker::Commerce.price(100..10_000.0) }
    purchase_date { Faker::Date.between(60.days.ago, Date.today) }
    base_date { Faker::Date.between(purchase_date, purchase_date.next_day(15)) }
    good_situation { GoodSituation.find(GoodSituation::SITUATIONS[:active]) }
    department
    good_category
  end

  factory :good_with_base_date_less_than_purchase_date, class: Good do
    description { Faker::Commerce.product_name }
    specification { Faker::Lorem.paragraph_by_chars(256, false) }
    purchase_price { Faker::Commerce.price(100..10_000.0) }
    purchase_date { Faker::Date.between(60.days.ago, Date.today) }
    base_date { Faker::Date.between(purchase_date.days_ago(10), purchase_date.days_ago(1)) }
    good_situation { GoodSituation.find(GoodSituation::SITUATIONS[:active]) }
    department
    good_category
  end

  factory :good_without_purchase_date, class: Good do
    description { Faker::Commerce.product_name }
    specification { Faker::Lorem.paragraph_by_chars(256, false) }
    purchase_price { Faker::Commerce.price(100..10_000.0) }
    base_date { Faker::Date.between(Date.today, Date.today.next_day(15)) }
    good_situation { GoodSituation.find(GoodSituation::SITUATIONS[:active]) }
    department
    good_category
  end
end
