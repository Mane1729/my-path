require 'rails_helper'

RSpec.describe Mutations::AssessUserArtAndCreativitySkill, type: :request do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'Art and Creativity') }
  let(:data) { graphql_query(mutation, variables: variables)['data']['assessUserArtAndCreativitySkill'] }

  let(:mutation) do
    <<~GQL
      mutation AssessUserArtAndCreativitySkill($ideaCount: Int!, $answer: String!) {
        assessUserArtAndCreativitySkill(ideaCount: $ideaCount, answer: $answer) {
          success
          errors
        }
      }
    GQL
  end

  let(:variables) do
    {
      ideaCount: 6,
      answer: 'ideas for art and creativity skill assessment question'
    }
  end

  before { post '/test_setup_session', params: { user_id: user.id } }

  context 'when passing valid input' do 
    it 'returns a success' do
      expect(data['success']).to be_truthy
      expect(data['errors']).to be_empty
    end
  end

  context 'when user does not exist' do
    before { post '/test_setup_session', params: { user_id: -1 } }

    it 'returns an error' do
      expect(data['success']).to be_falsey
      expect(data['errors']).to include('User not found')
    end
  end
end
