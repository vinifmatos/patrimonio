# frozen_string_literal: true

class DepreciationJob < ApplicationJob
  include ActiveJob::Status

  queue_as :default

  def perform(goods_ids, depreciation_date)
    goods = Good.where(id: goods_ids)
    goods.each do |good|
      good.depreciate(depreciation_date.to_date)
    end
  end
end
