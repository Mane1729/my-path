class CreateEmergingJobsSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :emerging_jobs_skills do |t|
      t.references :emerging_job, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
