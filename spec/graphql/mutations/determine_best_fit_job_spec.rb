require 'rails_helper'

RSpec.describe Mutations::DetermineBestFitJob, type: :request do
  let(:user) { create(:user_with_skills, skills: ['Customer focus', 'IT', 'Project management']) }
  let(:data) { graphql_query(mutation, variables: variables)['data']['determineBestFitJob'] }

  let(:mutation) do
    <<~GQL
    mutation DetermineBestFitJob($industries: [String!]){
      determineBestFitJob(industries: $industries){
        success
        errors
        emergingJob{
          id
        }
        lackingSkills{
          id
        }
      }
    }
    GQL
  end

  let(:variables) do
    {
      industries: []
    }
  end

  before { post '/test_setup_session', params: { user_id: user.id } }

  context 'when user does not exist' do
    before { post '/test_setup_session', params: { user_id: -1 } }

    it 'returns an error' do
      expect(data['success']).to be_falsey
      expect(data['errors']).to include('User not found')
    end
  end

  context 'when a best fit job exists' do
    let!(:skill1) { create(:skill, name: 'Art and Creativity') }
    let!(:skill2) { create(:skill, name: 'Social') }

    let!(:job1) { create(:emerging_job, skills: ['Customer focus', 'IT', 'Project management', 'Art and Creativity', 'Social']) }
    let!(:job2) { create(:emerging_job, skills: ['Art and Creativity', 'Social']) }
    let!(:job3) { create(:emerging_job, skills: ['Customer focus', 'IT', 'Social']) }

    it 'returns the best fit job and links it to the user' do
      expect(data['success']).to be true
      expect(data['errors']).to be_empty
      expect(data['emergingJob']['id']).to eq(job1.id.to_s)
    end

    it 'returns the lacking skills' do
      expect(data['lackingSkills']).to eq([
        { 'id' => skill1.id.to_s },
        { 'id' => skill2.id.to_s }
      ])
    end

    it 'links the job to the user' do
      graphql_query(mutation, variables:)
      expect(user.reload.emerging_job).to eq(job1)
    end
  end

  context 'when given industries' do
    let(:variables) do
      {
        industries: ['Management', 'Ecology']
      }
    end

    let!(:job1) { create(:emerging_job, industry: 'IT sector', skills: ['Customer focus', 'IT', 'Project management']) }
    let!(:job2) { create(:emerging_job, industry: 'Management', skills: ['Customer focus', 'IT']) }
    let!(:job3) { create(:emerging_job, industry: 'Ecology', skills: ['Customer focus', 'IT', 'Art and Creativity', 'Social']) }

    it 'returns the best fit filtered from given industries' do
      expect(data['success']).to be true
      expect(data['errors']).to be_empty
      expect(data['emergingJob']['id']).to eq(job2.id.to_s)
      expect(data['lackingSkills']).to eq([])
      expect(user.reload.emerging_job).to eq(job2)
    end
  end

  context 'when no jobs match' do
    it 'returns an error' do
      expect(data['success']).to be_falsey
      expect(data['errors']).to include('Data is not enough for finding a suitable job')
    end
  end
end
