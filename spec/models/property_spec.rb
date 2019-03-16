# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Property, type: :model do
  context 'is valid' do
    it 'with valid attributes' do
      property = build(:property)

      expect(property).to be_valid
    end
  end

  context 'is invalid' do
    it 'without description' do
      property = build(:property, description: nil)

      expect(property).to_not be_valid
    end
  end
end
