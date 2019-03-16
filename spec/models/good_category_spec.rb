# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoodCategory, type: :model do
  context 'is valid' do
    it 'with valid attributes' do
      good_category = build(:good_category)

      expect(good_category).to be_valid
    end
  end

  context 'is invalid' do
    it 'without description' do
      good_category = build(:good_category, description: nil)

      expect(good_category).to_not be_valid
    end

    it 'without sub kind' do
      good_category = build(:good_category, good_sub_kind: nil)

      expect(good_category).to_not be_valid
    end
  end
end
