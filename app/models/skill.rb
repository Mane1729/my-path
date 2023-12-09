class Skill < ApplicationRecord
  has_many :users_skills
  has_many :users, through: :users_skills
  has_many :users_lacking_skills
  has_many :lacking_users, through: :users_lacking_skills, source: :user
  has_many :emerging_jobs_skills
  has_many :emerging_jobs, through: :emerging_jobs_skills
end
