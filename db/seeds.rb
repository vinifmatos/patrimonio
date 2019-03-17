# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

GoodSituation::SITUATIONS.each do |k, v|
  GoodSituation.create(
    id: v,
    description: k
  )
end

MovementKind::KINDS.each do |k, v|
  MovementKind.create(
    id: v,
    description: k
  )
end

FinancialMovementKind::KINDS.each do |k, v|
  FinancialMovementKind.create(
    id: v,
    description: k
  )
end

DepreciationMethod::METHODS.each do |k, v|
  DepreciationMethod.create(
    id: v,
    description: k
  )
end
