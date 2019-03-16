# frozen_string_literal: true

FactoryBot.define do
  factory :movement do
    good
    department
    date { Faker::Date.between(good.movements.last.date, good.movements.last.date.next_day(30)) }
    movement_kind { MovementKind.take }
  end

  factory :movement_without_good, class: Movement do
    department
    date { Faker::Date.between(Date.today, Date.today.next_day(30)) }
    movement_kind { MovementKind.take }
  end
end
