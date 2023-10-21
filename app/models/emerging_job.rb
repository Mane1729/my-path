class EmergingJob < ApplicationRecord
  has_many :users
  has_many :emerging_jobs_skills
  has_many :skills, through: :emerging_jobs_skills
end