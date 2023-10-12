class EmergingJob < ApplicationRecord
  belongs_to :user, optional: true

  has_many :emerging_jobs_skills
  has_many :skills, through: :emerging_jobs_skills
end