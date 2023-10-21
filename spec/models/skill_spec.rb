require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe 'associations' do
    it { should have_many(:users_skills) }
    it { should have_many(:users).through(:users_skills) }
    it { should have_many(:emerging_jobs_skills) }
    it { should have_many(:emerging_jobs).through(:emerging_jobs_skills) }
  end
end
