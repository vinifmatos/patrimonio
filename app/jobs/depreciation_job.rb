# frozen_string_literal: true

class DepreciationJob < ApplicationJob
  include ActiveJob::Status

  queue_as :default

  def perform(goods_ids, depreciation_date, user)
    job = Job.create(
      job_id: @job_id,
      started_at: Time.now,
      user_id: user,
      kind: :depreciation
    )
    goods = Good.where(id: goods_ids)
    progress.total = goods.count
    goods.each do |good|
      good.depreciate(depreciation_date.to_date)
      progress.increment
    end
    job.update(
      finished_at: Time.now
    )
  end
end
