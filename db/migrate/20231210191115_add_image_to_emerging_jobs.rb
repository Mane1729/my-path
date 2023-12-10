class AddImageToEmergingJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :emerging_jobs, :image, :string
  end
end
