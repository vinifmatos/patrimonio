# frozen_string_literal: true

class DepreciationController < ApplicationController
  def index
    @goods = Good.active
    # @depreciations = FinancialMovement.depreciation.where(good_id: @goods.ids)
    @kinds = (GoodKind.all.select(:id, :description).map { |k| [k.description, k.id] }).sort
  end

  def get_sub_kinds
    @sub_kinds = GoodSubKind.where(good_kind_id: params[:id])
  end
end
