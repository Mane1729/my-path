require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_one(:profile) }
    it { should belong_to(:emerging_job) }
    it { should have_many(:users_skills) }
    it { should have_many(:skills).through(:users_skills) }
  end

  describe 'delegations' do
    it { should delegate_method(:working_hours).to(:profile) }
    it { should delegate_method(:public_speaking_points).to(:profile) }
    it { should delegate_method(:self_learning).to(:profile) }
    it { should delegate_method(:extra_courses).to(:profile) }
    it { should delegate_method(:plays_games).to(:profile) }
    it { should delegate_method(:team_player).to(:profile) }
    it { should delegate_method(:introvert).to(:profile) }
    it { should delegate_method(:reading_writing_skills).to(:profile) }
    it { should delegate_method(:memory_capability).to(:profile) }
    it { should delegate_method(:interested_subject).to(:profile) }
    it { should delegate_method(:fav_book_genre).to(:profile) }
    it { should delegate_method(:behaviour).to(:profile) }
    it { should delegate_method(:management_technical).to(:profile) }
    it { should delegate_method(:salary_work).to(:profile) }
    it { should delegate_method(:worker_type).to(:profile) }
  end
end
