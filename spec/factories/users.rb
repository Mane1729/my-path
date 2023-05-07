FactoryBot.define do
  factory :user do
    working_hours { rand(1..24) }
    public_speaking_points { rand(1..10) }
    self_learning { %w[yes no].sample }
    extra_courses { %w[yes no].sample }
    plays_games { %w[yes no].sample }
    team_player { %w[yes no].sample }
    introvert { %w[yes no].sample }
    reading_writing_skills { %w[excellent poor medium].sample }
    memory_capability { %w[excellent poor medium].sample }
    interested_subject { ["cloud computing", "networks", "hacking", "Computer Architecture", "programming", "parallel computing", "IOT", "data engineering", "Software Engineering", "Management"].sample }
    fav_book_genre { ["Prayer books", "Childrens", "Travel", "Romance", "Cookbooks", "Self help", "Drama", "Math", "Religion-Spirituality", "Anthology", "Trilogy", "Autobiographies", "Mystery", "Diaries", "Journals", "History", "Art", "Dictionaries", "Horror", "Encyclopedias", "Action and Adventure", "Fantasy", "Comics", "Science fiction", "Series", "Guide", "Biographies", "Health", "Satire", "Science", "Poetry"].sample }
    behaviour { %w[stubborn gentle].sample }
    management_technical { %w[Management Technical].sample }
    salary_work { %w[salary work].sample }
    worker_type { ["hard worker", "smart worker"].sample }
  end
end
