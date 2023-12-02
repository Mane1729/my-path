require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:working_hours) }
    it { should validate_presence_of(:public_speaking_points) }
    it { should validate_presence_of(:self_learning) }
    it { should validate_presence_of(:extra_courses) }
    it { should validate_presence_of(:plays_games) }
    it { should validate_presence_of(:team_player) }
    it { should validate_presence_of(:introvert) }
    it { should validate_presence_of(:reading_writing_skills) }
    it { should validate_presence_of(:memory_capability) }
    it { should validate_presence_of(:interested_subject) }
    it { should validate_presence_of(:fav_book_genre) }
    it { should validate_presence_of(:behaviour) }
    it { should validate_presence_of(:management_technical) }
    it { should validate_presence_of(:salary_work) }
    it { should validate_presence_of(:worker_type) }
  end
end
