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

      if @depreciation_movement.save
        @depreciation_movement
      else
        @depreciation_movement.errors
      end
    end

    private

    def constant_quotas
      months_to_depreciate =
        Utils.months_between(@good.base_date, @good.base_date.next_month(lifespan)) -
        Utils.months_between(@movement_date, (last_depreciation.try(:depreciation_date) || @good.base_date))
      monthly_depreciation_rate = yearly_depreciation_rate / 12
      percentage_to_depreciate = months_to_depreciate * monthly_depreciation_rate

      @depreciation_movement.amount = depreciable_amount * percentage_to_depreciate
      @depreciation_movement.depreciated_amount = @depreciation_movement.amount + (@last_depreciation.try(:depreciated_amount) || 0)
      @depreciation_movement.net_amount = (last_financial_movement.try(:net_amount) || 0) - @depreciation_movement.amount
    end

    def digits_sum; end

    def unitis_produced; end
  end
end
