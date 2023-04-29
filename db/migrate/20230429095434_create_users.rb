class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :working_hours
      t.integer :public_speaking_points
      t.boolean :self_learning
      t.boolean :extra_courses
      t.boolean :plays_games
      t.boolean :team_player
      t.boolean :introvert

      t.timestamps
    end
  end
end
