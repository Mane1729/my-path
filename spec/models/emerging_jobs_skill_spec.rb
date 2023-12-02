require 'rails_helper'

RSpec.describe EmergingJobsSkill, type: :model do
  describe 'associations' do
    it { should belong_to(:emerging_job) }
    it { should belong_to(:skill) }
  end
end
