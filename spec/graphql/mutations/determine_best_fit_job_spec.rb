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

    it 'returns ' do
      expect(data['success']).to be true
      expect(data['errors']).to be_empty
    end

    it 'links the best fit job and the lacking skills to the user ' do
      graphql_query(mutation, variables:)
      expect(user.reload.emerging_job).to eq(job1)
      expect(user.lacking_skills).to match_array([skill1, skill2])
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
    end

    it 'links the best fit filtered from given industries' do
      graphql_query(mutation, variables:)
      expect(user.reload.emerging_job).to eq(job2)
      expect(user.lacking_skills).to eq([])
    end 
  end

  context 'when no jobs match' do
    it 'returns an error' do
      expect(data['success']).to be_falsey
      expect(data['errors']).to include('Data is not enough for finding a suitable job')
    end
  end
end
