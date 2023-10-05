class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.integer :working_hours, null: false
      t.integer :public_speaking_points, null: false
      t.enum :self_learning, enum_type: 'yes_no', null: false
      t.enum :extra_courses, enum_type: 'yes_no', null: false
      t.enum :plays_games, enum_type: 'yes_no', null: false
      t.enum :team_player, enum_type: 'yes_no', null: false
      t.enum :introvert, enum_type: 'yes_no', null: false
      t.enum :reading_writing_skills, enum_type: 'quality', null: false
      t.enum :memory_capability, enum_type: 'quality', null: false
      t.enum :interested_subject, enum_type: 'interested_subject', null: false
      t.enum :fav_book_genre, enum_type: 'book_genre', null: false
      t.enum :behaviour, enum_type: 'behaviour', null: false
      t.enum :management_technical, enum_type: 'management_technical', null: false
      t.enum :salary_work, enum_type: 'salary_work', null: false
      t.enum :worker_type, enum_type: 'worker_type', null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
