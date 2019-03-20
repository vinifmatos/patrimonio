# frozen_string_literal: true

class DepreciationController < ApplicationController
  def index
    @goods = Good.active
    # @depreciations = FinancialMovement.depreciation.where(good_id: @goods.ids)
  end
end
