class AddEmergingJobToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :emerging_job, foreign_key: true
  end
end
