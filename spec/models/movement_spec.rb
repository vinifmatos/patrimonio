# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movement, type: :model do
  context 'is valid' do
    it 'with valids attributes' do
      movement = build(:movement)

      expect(movement).to be_valid
    end
  end

  context 'is not valid' do
    it 'without date' do
      movement = build(:movement, date: nil)

      expect(movement).to_not be_valid
    end

    it 'without department' do
      movement = build(:movement, department: nil)

      expect(movement).to_not be_valid
    end

    it 'without movement kind' do
      movement = build(:movement, movement_kind: nil)

      expect(movement).to_not be_valid
    end

    it 'without good' do
      movement = build(:movement_without_good)

      expect(movement).to_not be_valid
    end

    it 'with date less then last move date' do
      good = create(:good)
      movement = build(:movement, good: good, date: good.movements.last.date.days_ago(10))

      expect(movement).to_not be_valid
    end
  end
end
