# frozen_string_literal: true

# ActiveJob::Status.store = :redis_store

ActiveJob::Status.store = Rails.cache
