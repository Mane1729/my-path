class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :working_hours, null: false
      t.integer :public_speaking_points, null: false

      t.timestamps
    end
  end
end
