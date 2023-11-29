require 'rails_helper'

RSpec.describe Mutations::AssessUserInformationTechnologySkill, type: :request do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'IT') }
  let(:data) { graphql_query(mutation, variables: variables)['data']['assessUserInformationTechnologySkill'] }

  let(:mutation) do
    <<~GQL
      mutation AssessUserInformationTechnologySkill($answers: InformationTechnologyQuestionnaireInput!) {
        assessUserInformationTechnologySkill(answers: $answers) {
          success
          errors
        }
      }
    GQL
  end

  let(:variables) do
    {
      answers: {
        ageProblem: 'a', 
        numberSeriesNext: 'c',
        sequenceNext: 'b',
        logicalDeduction: 'c',
        comparativeCost: 'b',
        ipAssignmentProtocol: 'b',
        directoryViewCommand: 'd',
        volatileMemoryComponent: 'a', 
        hierarchicalDataStructure: 'c',
        webPageFetchProtocol: 'b'
      }
    }
  end

  before { post '/test_setup_session', params: { user_id: user.id } }

  context 'when user has an IT skill' do
    it 'creates a UsersSkill record' do
      expect { graphql_query(mutation, variables: variables) }.to change { UsersSkill.count }.by(1)
    end
     
    it 'returns a success' do
      expect(data['success']).to be_truthy
      expect(data['errors']).to be_empty
    end
  end

  context 'when user does not have an IT skill' do
    let(:variables) do
      {
        answers: {
          ageProblem: 'b', 
          numberSeriesNext: 'd',
          sequenceNext: 'b',
          logicalDeduction: 'c',
          comparativeCost: 'a',
          ipAssignmentProtocol: 'b',
          directoryViewCommand: 'd',
          volatileMemoryComponent: 'a', 
          hierarchicalDataStructure: 'c',
          webPageFetchProtocol: 'b'
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
