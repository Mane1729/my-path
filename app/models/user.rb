class User < ApplicationRecord
  has_one :profile, autosave: true
  belongs_to :emerging_job, optional: true
  has_many :users_skills
  has_many :skills, through: :users_skills
  has_many :users_lacking_skills
  has_many :lacking_skills, through: :users_lacking_skills, source: :skill

  delegate :working_hours, :public_speaking_points, :self_learning, :extra_courses, :plays_games, :team_player, 
           :introvert, :reading_writing_skills, :memory_capability, :interested_subject, :fav_book_genre, :behaviour, 
           :management_technical, :salary_work, :worker_type, to: :profile
end
