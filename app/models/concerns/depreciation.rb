# frozen_string_literal: true

module Depreciation
  extend ActiveSupport::Concern

  METHODS = { constant_quotas: 0, digits_sum: 1, unitis_produced: 2 }.freeze

  def depreciate(movement_date)
    depreciator = Depreciator.new(self, movement_date)
    depreciator.depreciate
  end

  class Depreciator
    def initialize(good, movement_date)
      @good = good
      @movement_date = movement_date
      @last_depreciation = @good.last_depreciation
      @depreciation_movement = FinancialMovement.new(
        good: @good,
        financial_movement_kind_id: FinancialMovementKind::KINDS[:depreciation],
        date: movement_date
      )
    end

    def depreciate
      return if @movement_date.day < @good.base_date.day

      if @good.depreciation_method == METHODS[:constant_quotas]
        constant_quotas
      elsif @good.depreciation_method == METHODS[:digits_sum]
        digits_sum
      elsif @good.depreciation_method == METHODS[:unitis_produced]
        unitis_produced
      end

      @depreciation_movement.save
      @depreciation_movement
    end

    private

    def constant_quotas
      monthly_depreciation_rate = @good.yearly_depreciation_rate / 12
      percentage_to_depreciate = months_to_depreciate * monthly_depreciation_rate

      @depreciation_movement.amount = @good.depreciable_amount * percentage_to_depreciate * -1
      @depreciation_movement.net_amount = (@good.last_financial_movement.try(:net_amount) || 0) + @depreciation_movement.amount
      @depreciation_movement.depreciated_amount = @depreciation_movement.amount.abs + @good.depreciated_amount
    end

    def digits_sum; end

    def unitis_produced; end

    def months_to_depreciate
      deprecited_months = Utils.months_between(@good.base_date, (@last_depreciation.try(:depreciation_date) || @good.base_date))
      not_deprecited_months = @good.lifespan - deprecited_months
      months = Utils.months_between(@movement_date, (@last_depreciation.try(:depreciation_date) || @good.base_date))
      if months <= not_deprecited_months
        months
      else
        not_deprecited_months
      end
    end
  end
end
