class CreateAppliedJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :applied_jobs do |t|
      t.bigint :job_listing_id
      t.bigint :talent_id

      t.timestamps
    end

    add_foreign_key :applied_jobs, :job_listings
    add_foreign_key :applied_jobs, :users, column: :talent_id
    add_index :applied_jobs, :job_listing_id
    add_index :applied_jobs, :talent_id
  end
end
