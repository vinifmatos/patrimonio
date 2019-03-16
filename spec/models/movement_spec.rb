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

    it 'with date less then last movement date' do
      good = create(:good)
      movement = build(:movement, good: good, date: good.movements.last.date.days_ago(10))

      expect(movement).to_not be_valid
    end
  end

  context 'kind is tranference' do
    let(:movement_kind) { MovementKind.find(MovementKind::KINDS[:transference]) }

    context 'is invalid' do
      it 'with department equals to last movement department' do
        good = create(:good)
        movement = build(:movement, good: good, department: good.movements.last.department, movement_kind: movement_kind)
        expect(movement).to_not be_valid
      end

      it 'if good situation is inative' do
        good = create(:good)
        good.update(good_situation_id: GoodSituation::SITUATIONS[:inactive])
        movement = build(:movement, good: good, movement_kind: movement_kind)

        expect(movement).to_not be_valid
      end

      it 'if good is situation is borrowed'
    end
  end

  context 'kind is borrowing' do
    context 'is not valid' do
      it 'if good situation is inative'
    end
  end
end
