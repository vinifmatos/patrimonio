# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :job_id
      t.references :user, foreign_key: true
      t.datetime :started_at
      t.datetime :finished_at
      t.integer :kind

      t.timestamps
    end
  end
end
