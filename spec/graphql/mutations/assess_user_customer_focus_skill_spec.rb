require 'rails_helper'

RSpec.describe Mutations::AssessUserCustomerFocusSkill, type: :request do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'Customer focus') }
  let(:data) { graphql_query(mutation, variables: variables)['data']['assessUserCustomerFocusSkill'] }

  let(:mutation) do
    <<~GQL
      mutation AssessUserCustomerFocusSkill($userId: ID!, $answers: CustomerFocusQuestionnaireInput!) {
        assessUserCustomerFocusSkill(userId: $userId, answers: $answers) {
          success
          errors
        }
      }
    GQL
  end

  let(:variables) do
    {
      userId: user.id,
      answers: {
        initialResponse: 'c',
        addressingEmotion: 'b',
        proposedSolution: 'a',
        handlingNegativePublicity: 'c',
        futureTrustAssurance: 'c'
      }
    }
  end

  context 'when user has a customer focus skill' do
    it 'creates a UsersSkill record' do
      # TODO: Check for the right skill (same for other specs)
      expect { graphql_query(mutation, variables: variables) }.to change { UsersSkill.count }.by(1)
    end
     
    it 'returns a success' do
      expect(data['success']).to be_truthy
      expect(data['errors']).to be_empty
    end
  end

  context 'when user does not have a customer focus skill' do
    let(:variables) do
      {
        userId: user.id,
        answers: {
          initialResponse: 'c',
          addressingEmotion: 'a',
          proposedSolution: 'b',
          handlingNegativePublicity: 'c',
          futureTrustAssurance: 'a'
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
    let(:variables) do
      {
        userId: -1, 
        answers: {
          initialResponse: 'c',
          addressingEmotion: 'b',
          proposedSolution: 'a',
          handlingNegativePublicity: 'c',
          futureTrustAssurance: 'c'
        }
      }
    end

    it 'returns an error' do
      expect(data['success']).to be_falsey
      expect(data['errors']).to include('User not found')
    end
  end
end
