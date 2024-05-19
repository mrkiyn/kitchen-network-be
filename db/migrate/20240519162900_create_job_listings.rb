class CreateJobListings < ActiveRecord::Migration[7.1]
  def change
    create_table :job_listings do |t|
      t.string :title
      t.text :description
      t.text :requirements
      t.decimal :salary
      t.bigint :owner_id

      t.timestamps
    end

    add_foreign_key :job_listings, :users, column: :owner_id
    add_index :job_listings, :owner_id
  end
end
