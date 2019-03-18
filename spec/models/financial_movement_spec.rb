# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FinancialMovement, type: :model do
  context 'is valid' do
    it 'with valid attributes' do
      good = create(:good)
      financial_movement = build(:financial_movement, good: good)

      expect(financial_movement).to be_valid
    end
  end

  context 'is invalid' do
    it 'without date' do
      good = create(:good)
      financial_movement = build(:financial_movement, good: good, date: nil)

      expect(financial_movement).to_not be_valid
    end

    it 'without kind' do
      good = create(:good)
      financial_movement = build(:financial_movement, good: good, kind: nil)

      expect(financial_movement).to_not be_valid
    end

    it 'without amount' do
      good = create(:good)
      financial_movement = build(:financial_movement, good: good, amount: nil)

      expect(financial_movement).to_not be_valid
    end

    it 'with date less than last financial movement date' do
      good = create(:good)
      financial_movement = build(:financial_movement, good: good, date: good.financial_movements.last.date.days_ago(1))

      expect(financial_movement).to_not be_valid
    end

    it 'if good are inactive' do
      good = create(:good)
      good.update(good_situation_id: GoodSituation::SITUATIONS[:inactive])
      financial_movement = build(:financial_movement, good: good)

      expect(financial_movement).to_not be_valid
    end

    it 'if kind is initial and as negative amount' do
      good = create(:good)
      financial_movement = build(:financial_movement,
                                 good: good,
                                 amount: -1,
                                 kind: FinancialMovementKind.find(
                                   FinancialMovementKind::KINDS[:initial]
                                 ))

      expect(financial_movement).to_not be_valid
    end

    it 'if kind is revaluation and as negative amount' do
      good = create(:good)
      financial_movement = build(:financial_movement,
                                 good: good,
                                 amount: -1,
                                 kind: FinancialMovementKind.find(
                                   FinancialMovementKind::KINDS[:revaluation]
                                 ))

      expect(financial_movement).to_not be_valid
    end

    it 'if kind is depreciation and as positive amount' do
      good = create(:good)
      financial_movement = build(:financial_movement,
                                 good: good,
                                 amount: 1,
                                 kind: FinancialMovementKind.find(
                                   FinancialMovementKind::KINDS[:depreciation]
                                 ))

      expect(financial_movement).to_not be_valid
    end

    it 'if amount of depreciation is greater than the depreciable amount' do
      good = create(:good)
      financial_movement = build(:financial_movement,
                                 good: good,
                                 amount: good.depreciable_amount + 1,
                                 kind: FinancialMovementKind.find(
                                   FinancialMovementKind::KINDS[:depreciation]
                                 ))

      expect(financial_movement).to_not be_valid
    end
  end
end
