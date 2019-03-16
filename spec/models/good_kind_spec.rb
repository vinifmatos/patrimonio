# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoodKind, type: :model do
  context 'is valid' do
    it 'with valid attributes' do
      good_kind = build(:good_kind)

      expect(good_kind).to be_valid
    end
  end

  context 'is invalid' do
    it 'without description' do
      good_kind = build(:good_kind, description: nil)

      expect(good_kind).to_not be_valid
    end
  end
end
