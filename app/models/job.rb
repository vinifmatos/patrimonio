# frozen_string_literal: true

class Job < ApplicationRecord
  belongs_to :user
  enum kind: [:depreciation]
end
