# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Department, type: :model do
  context 'is valid' do
    it 'with valid attributes' do
      department = build(:department)

      expect(department).to be_valid
    end
  end

  context 'is invalid' do
    it 'without description' do
      department = build(:department, description: nil)

      expect(department).to_not be_valid
    end

    it 'without property' do
      department = build(:department, property: nil)

      expect(department).to_not be_valid
    end
  end
end
