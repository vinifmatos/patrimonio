# frozen_string_literal: true

class DepreciationJob < ApplicationJob
  include ActiveJob::Status

  queue_as :default

  def perform(goods_ids, depreciation_date)
    goods = Good.where(id: goods_ids)
    progress.total = goods.count
    goods.each do |good|
      good.depreciate(depreciation_date.to_date)
      progress.increment
    end
  end
end
