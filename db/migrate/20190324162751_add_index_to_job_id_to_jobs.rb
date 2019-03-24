# frozen_string_literal: true

class AddIndexToJobIdToJobs < ActiveRecord::Migration[5.2]
  def change
    add_index :jobs, :job_id
  end
end
