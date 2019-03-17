# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoodSubKind, type: :model do
  context 'is valid' do
    it 'with valid attributes' do
      good_sub_kind = build(:good_sub_kind)

      expect(good_sub_kind).to be_valid
    end
  end

  context 'is invalid' do
    it 'without description' do
      good_sub_kind = build(:good_sub_kind, description: nil)

      expect(good_sub_kind).to_not be_valid
    end

    it 'without kind' do
      good_sub_kind = build(:good_sub_kind, good_kind: nil)

      expect(good_sub_kind).to_not be_valid
    end

    it 'without depreciation method' do
      good_sub_kind = build(:good_sub_kind, depreciation_method: nil)

      expect(good_sub_kind).to_not be_valid
    end
  end
end
