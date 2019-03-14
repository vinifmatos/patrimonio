# frozen_string_literal: true

namespace :dev do
  desc 'TODO'
  task setup: :environment do
    puts 'Criando DB...'
    `rails db:create db:migrate db:seed`

    puts 'Criando goods...'
    FactoryBot.create_list(:good_full, 30)
  end

  task resetup: :environment do
    puts 'Criando DB...'
    `rails db:drop db:create db:migrate db:seed`

    puts 'Criando goods...'
    FactoryBot.create_list(:good_full, 30)
  end
end
