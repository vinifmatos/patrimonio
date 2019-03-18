# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Good, type: :model do
  context 'is valid' do
    it 'with valid attributes' do
      good = build(:good)

      expect(good).to be_valid
    end
  end

  context 'is invalid' do
    it 'without description' do
      good = build(:good, description: nil)

      expect(good).to_not be_valid
    end

    it 'without purchase date' do
      good = build(:good_without_purchase_date)

      expect(good).to_not be_valid
    end

    it 'without purchase price' do
      good = build(:good, purchase_price: nil)

      expect(good).to_not be_valid
    end

    it 'without base date' do
      good = build(:good, base_date: nil)

      expect(good).to_not be_valid
    end

    it 'without situation' do
      good = build(:good, situation: nil)

      expect(good).to_not be_valid
    end

    it 'without department' do
      good = build(:good, department: nil)

      expect(good).to_not be_valid
    end

    it 'without category' do
      good = build(:good, category: nil)

      expect(good).to_not be_valid
    end

    it 'with duplicated code' do
      good = create(:good)
      good2 = build(:good, code: good.code)

      expect(good2).to_not be_valid
    end

    it 'with negative purchase price' do
      good = build(:good, purchase_price: -1)

      expect(good).to_not be_valid
    end

    it 'with base date less than purchase date' do
      good = build(:good_with_base_date_less_than_purchase_date)

      expect(good).to_not be_valid
    end
  end

  context 'raise ActiveRecord::RecordInvalid' do
    context 'on create' do
      it 'with situation inactive' do
        expect do
          create(:good,
                 situation: GoodSituation
                      .find(GoodSituation::SITUATIONS[:inactive]))
        end.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'with situation borrowed' do
        expect do
          create(:good,
                 situation: GoodSituation
                      .find(GoodSituation::SITUATIONS[:borrowed]))
        end.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'with situation maintenance' do
        expect do
          create(:good,
                 situation: GoodSituation
                      .find(GoodSituation::SITUATIONS[:maintenance]))
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  context 'on create' do
    it 'generate initial movement' do
      expect { create(:good) }.to change(Movement, :count).by(1)
    end

    it 'generate initial financial movement' do
      expect { create(:good) }.to change(FinancialMovement, :count).by(1)
    end
  end
end
