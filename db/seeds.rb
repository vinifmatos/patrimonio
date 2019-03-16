# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

{ active: 0, inactive: 1, borrowed: 2, maintenance: 3 }.each do |k, v|
  GoodSituation.create(
    id: v,
    description: k
  )
end

{ incorporation: 0, borrowing: 1, transference: 2, inactivation: 3, maintence: 4 }.each do |k, v|
  MovementKind.create(
    id: v,
    description: k
  )
end

{ initial: 0, revaluation: 1, depreciation: 2 }.each do |k, v|
  FinancialMovementKind.create(
    id: v,
    description: k
  )
end
