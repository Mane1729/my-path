class Skill < ApplicationRecord
  has_many :user_skills
  has_many :users, through: :user_skills
  has_many :emerging_jobs_skills
  has_many :emerging_jobs, through: :emerging_jobs_skills
end