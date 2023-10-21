FactoryBot.define do
  factory :user do

    factory :user_with_profile do
      after(:create) do |user, evaluator|
        create(:profile, user:)
      end
    end
  end
end
