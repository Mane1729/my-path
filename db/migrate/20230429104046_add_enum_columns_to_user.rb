class AddEnumColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.enum :self_learning, enum_type: 'yes_no'
      t.enum :extra_courses, enum_type: 'yes_no'
      t.enum :reading_writing_skills, enum_type: 'quality'
      t.enum :memory_capability, enum_type: 'quality'
      t.enum :interested_subject, enum_type: 'interested_subject'
      t.enum :plays_games, enum_type: 'yes_no'
      t.enum :fav_book_genre, enum_type: 'book_genre'
      t.enum :behaviour, enum_type: 'behaviour'
      t.enum :management_technical, enum_type: 'management_technical'
      t.enum :salary_work, enum_type: 'salary_work'
      t.enum :worker_type, enum_type: 'worker_type'
      t.enum :team_player, enum_type: 'yes_no'
      t.enum :introvert, enum_type: 'yes_no'
      t.enum :career, enum_type: 'career'
    end
  end
end
