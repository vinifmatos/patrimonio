# frozen_string_literal: true

class Movement < ApplicationRecord
  enum kind: %i[initial depreciation inactivation]
  belongs_to :good
  belongs_to :department
end
