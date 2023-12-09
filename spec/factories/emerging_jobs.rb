FactoryBot.define do
  factory :emerging_job do
    name { Faker::Job.title }
    industry { ['Education', 'Metallurgy', 'Management'].sample }
    description { Faker::Lorem.sentence(word_count: 10) }

    transient do
      skills { [] }
    end

    after(:create) do |emerging_job, evaluator|
      skills = evaluator.skills.map do |skill_name|
        Skill.find_or_create_by(name: skill_name)
      end
      emerging_job.skills << skills
    end
  end
end
