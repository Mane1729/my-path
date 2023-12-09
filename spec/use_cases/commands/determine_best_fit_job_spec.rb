require 'rails_helper'

RSpec.describe Commands::DetermineBestFitJob do
  let(:user) { create(:user_with_skills, skills: ['Customer focus', 'IT', 'Project management']) }
  let(:industries) { [] }

  subject(:result) do
    described_class.call(user_id: user.id, industries:)
  end

  describe '.call' do
    context 'when the user is not found' do
      it 'returns an error' do
        result = described_class.call(user_id: -1, industries:)

        expect(result[:success]).to be false
        expect(result[:errors]).to include('User not found')
      end
    end

    context "when the user doesn't have any skills" do
      let(:user) { create(:user) }

      it 'returns an error' do
        expect(result[:success]).to be false
        expect(result[:errors]).to include('Data is not enough for finding a suitable job')
      end
    end

    context "when DB contains a job that matches exactly user's skills" do
      let!(:job1) { create(:emerging_job, skills: ['Customer focus', 'IT', 'Project management']) }
      let!(:job2) { create(:emerging_job, skills: ['IT', 'Project management']) }
      let!(:job3) { create(:emerging_job, skills: ['Customer focus', 'IT', 'Social']) }

      it 'returns success' do
        expect(result[:success]).to be true
        expect(result[:errors]).to be_empty
      end

      it 'links the job to the user' do
        result
        expect(user.reload.emerging_job).to eq(job1)
        expect(user.lacking_skills).to eq([])
      end
    end

    context 'when no jobs match' do
      it 'returns an error' do
        expect(result[:success]).to be false
        expect(result[:errors]).to include('Data is not enough for finding a suitable job')
      end
    end

    context 'when the best fit job require a few additional skills' do
      let!(:skill1) { create(:skill, name: 'Art and Creativity') }
      let!(:skill2) { create(:skill, name: 'Social') }

      let!(:job1) { create(:emerging_job, skills: ['Customer focus', 'IT', 'Project management', 'Art and Creativity', 'Social']) }
      let!(:job2) { create(:emerging_job, skills: ['Art and Creativity', 'Social']) }
      let!(:job3) { create(:emerging_job, skills: ['Customer focus', 'IT', 'Social']) }

      it 'returns success' do
        expect(result[:success]).to be true
        expect(result[:errors]).to be_empty
      end

      it 'links the best fit job and lacking skills to the user' do
        result
        expect(user.reload.emerging_job).to eq(job1)
        expect(user.lacking_skills).to match_array([skill1, skill2])
      end
    end

    context 'when there are a few jobs with additional skills' do
      let!(:skill) { create(:skill, name: 'Social') }

      let!(:job1) { create(:emerging_job, skills: ['Customer focus', 'IT', 'Project management', 'Art and Creativity', 'Social', 'Lean production']) }
      let!(:job2) { create(:emerging_job, skills: ['Customer focus', 'IT', 'Art and Creativity', 'Social']) }
      let!(:job3) { create(:emerging_job, skills: ['Customer focus', 'IT', 'Social']) }


      it 'returns success' do
        expect(result[:success]).to be true
        expect(result[:errors]).to be_empty
      end

      it 'links the best fit job found by maximizing matching skills and minimizing lacking skills' do
        result
        expect(user.reload.emerging_job).to eq(job3)
        expect(user.lacking_skills).to eq([skill])
      end
    end

    context 'when the best fit job require a lot of additional skills' do
      let!(:job) { create(:emerging_job, skills: ['Customer focus', 'IT', 'Project management', 'Art and Creativity', 'Social', 'Lean production', 'Systems thinking']) }

      it 'returns an error' do
        expect(result[:success]).to be false
        expect(result[:errors]).to include('Data is not enough for finding a suitable job')
      end
    end

    context 'when given industries' do
      let(:industries) { ['Management', 'Ecology'] }

      let!(:job1) { create(:emerging_job, industry: 'IT sector', skills: ['Customer focus', 'IT', 'Project management']) }
      let!(:job2) { create(:emerging_job, industry: 'Management', skills: ['Customer focus', 'IT']) }
      let!(:job3) { create(:emerging_job, industry: 'Ecology', skills: ['Customer focus', 'IT', 'Art and Creativity', 'Social']) }

      it 'returns success' do
        expect(result[:success]).to be true
        expect(result[:errors]).to be_empty
      end

      it 'links the best fit filtered from given industries' do
        result
        expect(user.reload.emerging_job).to eq(job2)
        expect(user.lacking_skills).to eq([])
      end 
    end
  end
end
