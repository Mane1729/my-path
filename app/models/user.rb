class User < ApplicationRecord
  validates :working_hours, presence: true
  validates :public_speaking_points, presence: true
  validates :self_learning, presence: true
  validates :extra_courses, presence: true
  validates :plays_games, presence: true
  validates :team_player, presence: true
  validates :introvert, presence: true
  validates :reading_writing_skills, presence: true
  validates :memory_capability, presence: true
  validates :interested_subject, presence: true
  validates :fav_book_genre, presence: true
  validates :behaviour, presence: true
  validates :management_technical, presence: true
  validates :salary_work, presence: true
  validates :worker_type, presence: true
end
