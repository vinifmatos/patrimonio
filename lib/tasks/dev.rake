# frozen_string_literal: true

namespace :dev do
  desc 'TODO'
  task setup: :environment do
    puts 'Criando DB...'
    `rails db:create db:migrate db:seed`

    puts 'Criando goods...'
    FactoryBot.create_list(:good, 30)
  end

  task resetup: :environment do
    puts 'Criando DB...'
    `rails db:drop db:create db:migrate db:seed`

    puts 'Criando goods...'
    FactoryBot.create_list(:kind, 5)

    puts 'Criando Sub Tipos...'
    GoodKind.all.each { |k| FactoryBot.create_list(:sub_kind, 5, kind: k) }

    puts 'Criando Categorias...'
    GoodSubKind.all.each { |sk| FactoryBot.create_list(:category, 5, sub_kind: sk) }

    puts 'Criando bens...'
    GoodCategory.all.each { |c| FactoryBot.create_list(:good, 10, category: c) }
  end

  task seedtest: :environment do
    puts 'Seeding test DB...'
    `RAILS_ENV=test rails db:migrate db:seed`
  end
end
