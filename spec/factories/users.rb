FactoryBot.define do
  factory :user do

    factory :user_with_profile do
      after(:create) do |user, evaluator|
        create(:profile, user:)
      end
    end

    factory :user_with_skills do
      transient do
        skills { [] }
      end

      after(:create) do |user, evaluator|
        evaluator.skills.each do |skill_name|
          skill = Skill.find_or_create_by(name: skill_name)
          user.skills << skill
        end
      end
    end
  end
end
