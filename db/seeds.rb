# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

EmergingJobsSkill.destroy_all
EmergingJob.destroy_all
Skill.destroy_all

# Create skills
skills = JSON.parse(File.read('db/skills.json'))

skills.each do |skill_name|
  Skill.create!(name: skill_name)
end

# Create emerging jobs
jobs = JSON.parse(File.read('db/emerging_jobs.json'))

jobs.each do |job_data|
  job = EmergingJob.create!(
    name: job_data["name"],
    industry: job_data["industry"],
    description: job_data["description"]
  )

  job_data["skills"].each do |skill_name|
    skill = Skill.find_by(name: skill_name)
    if skill
      EmergingJobsSkill.create!(
        emerging_job: job,
        skill: skill
      )
    end
  end
end
