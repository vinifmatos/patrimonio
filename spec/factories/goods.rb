# frozen_string_literal: true

FactoryBot.define do
  factory :good do
    code { 1 }
    description { Faker::Commerce.product_name }
    specification { Faker::Lorem.paragraph_by_chars(256, false) }
    purchase_price { Faker::Commerce.price }
    purchase_date { Faker::Date.between(300.days.ago, Date.today) }
    base_date { Faker::Date.between(Date.today, 2.days.after) }
    situation { Good.situations.values.sample }
    department
    good_category
  end
end
