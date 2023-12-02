require 'rails_helper'

RSpec.describe EmergingJob, type: :model do
  describe 'associations' do
    it { should have_many(:users) }
    it { should have_many(:emerging_jobs_skills) }
    it { should have_many(:skills).through(:emerging_jobs_skills) }
  end
end
