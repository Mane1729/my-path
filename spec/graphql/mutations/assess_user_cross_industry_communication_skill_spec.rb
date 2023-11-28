require 'rails_helper'

RSpec.describe Mutations::AssessUserCrossIndustryCommunicationSkill, type: :request do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'Cross-industry communication') }
  let(:data) { graphql_query(mutation, variables: variables)['data']['assessUserCrossIndustryCommunicationSkill'] }

  let(:mutation) do
    <<~GQL
      mutation AssessUserCrossIndustryCommunicationSkill($answers: CrossIndustryCommunicationQuestionnaireInput!) {
        assessUserCrossIndustryCommunicationSkill(answers: $answers) {
          success
          errors
        }
      }
    GQL
  end

  let(:variables) do
    {
      answers: {
        dataScientistQuestion: 'b',
        architectQuestion: 'b',
        telecommunicationExpertQuestion: 'a',
        publicHealthOfficialQuestion: 'b',
      }
    }
  end

  before { post '/test_setup_session', params: { user_id: user.id } }

  context 'when user has a cross-industry communication skill' do
    it 'creates a UsersSkill record' do
      expect { graphql_query(mutation, variables: variables) }.to change { UsersSkill.count }.by(1)
    end
     
    it 'returns a success' do
      expect(data['success']).to be_truthy
      expect(data['errors']).to be_empty
    end
  end

  context 'when user does not have a cross-industry communication skill' do
    let(:variables) do
      {
        answers: {
          dataScientistQuestion: 'c',
          architectQuestion: 'b',
          telecommunicationExpertQuestion: 'a',
          publicHealthOfficialQuestion: 'c',
        }
      }
    end

    it 'does not create a UsersSkill record and returns a success' do
      expect { graphql_query(mutation, variables: variables) }.not_to change { UsersSkill.count }
    end

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
