# frozen_string_literal: true

module Utils
  def months_between(date1 = Time.now, date2 = Time.now)
    date1 ||= Time.now
    date2 ||= Time.now

    if date1 > date2
      recent_date = date1.to_date
      past_date = date2.to_date
    else
      recent_date = date2.to_date
      past_date = date1.to_date
    end
    months = (recent_date.month - past_date.month) + 12 * (recent_date.year - past_date.year)
    return months - 1 if recent_date.day < past_date.day

    months
  end

  module Redis
    def self.connection=(conn)
      @connection = conn
    end

    def self.connection
      @connection
    end

    def self.get(key)
      Redis.connection.get(key)
    end

    def self.store(key, value)
      Redis.connection.set(key, value.to_s)
    end

    def self.get_hash(key)
      json = Redis.connection.get(key)
      json = '{"jobs": []}' if json.nil?
      JSON.parse(json)
    end

    def self.store_hash(key, hash)
      raise ArgumentError('Argument given is not hash') unless hash.is_a?(Hash)

      Redis.connection.set(key, hash.to_json)
    end
  end

  module UserJobs
    @prefix = 'user_jobs_'

    def self.get(user)
      user_id = user.is_a?(Integer) ? user : user.id
      jobs_hash = Redis.get_hash("#{@prefix}#{user_id}")
      jobs_hash['jobs'].select! { |job| job if ActiveJob::Status.get(job).present? }
      jobs_hash['jobs'].map do |job|
        status = ActiveJob::Status.get(job)
        next unless status.present?

        { status: status.status, progress: (status.progress.positive? ? (status.progress * 100).round(2) : 0) }
      end
    end

    def self.set(user, job)
      user_id = user.is_a?(Integer) ? user : user.id
      job_id = job.is_a?(String) ? job : job.job_id
      jobs_hash = Redis.get_hash("#{@prefix}#{user_id}")
      jobs = []
      jobs = jobs_hash['jobs'].select { |jobi| jobi if ActiveJob::Status.get(jobi).present? } unless jobs_hash['jobs'].nil?
      jobs << job_id
      jobs_hash[:jobs] = jobs
      Redis.store_hash("#{@prefix}#{user_id}", jobs_hash)
    end
  end
end
