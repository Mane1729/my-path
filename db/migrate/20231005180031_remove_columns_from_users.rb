class RemoveColumnsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :working_hours
    remove_column :users, :public_speaking_points
    remove_column :users, :self_learning
    remove_column :users, :extra_courses
    remove_column :users, :plays_games
    remove_column :users, :team_player
    remove_column :users, :introvert
    remove_column :users, :reading_writing_skills
    remove_column :users, :memory_capability
    remove_column :users, :interested_subject
    remove_column :users, :fav_book_genre
    remove_column :users, :behaviour
    remove_column :users, :management_technical
    remove_column :users, :salary_work
    remove_column :users, :worker_type
  end
end
