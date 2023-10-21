class Skill < ApplicationRecord
  has_many :users_skills
  has_many :users, through: :users_skills
  has_many :emerging_jobs_skills
  has_many :emerging_jobs, through: :emerging_jobs_skills
end
