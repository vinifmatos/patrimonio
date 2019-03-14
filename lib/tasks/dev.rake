# frozen_string_literal: true

namespace :dev do
  desc 'TODO'
  task setup: :environment do
    puts 'Criando DB...'
    `rails db:create db:migrate`

    puts 'Criando goods...'
    FactoryBot.create_lsit(:good)
  end

  task resetup: :environment do
    puts 'Criando DB...'
    `rails db:drop db:create db:migrate`

    puts 'Criando goods...'
    FactoryBot.create_list(:good_full, 30)
  end
end
