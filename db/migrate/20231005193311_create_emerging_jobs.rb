class CreateEmergingJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :emerging_jobs do |t|
      t.string :name, null: false
      t.string :industry, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
