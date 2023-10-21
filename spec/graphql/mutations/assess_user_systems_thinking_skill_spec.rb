require 'rails_helper'

RSpec.describe Mutations::AssessUserSystemsThinkingSkill, type: :request do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'Systems thinking') }
  let(:data) { graphql_query(mutation, variables: variables)['data']['assessUserSystemsThinkingSkill'] }

  let(:mutation) do
    <<~GQL
      mutation AssessUserSystemsThinkingSkill($userId: ID!, $answers: SystemsThinkingQuestionnaireInput!) {
        assessUserSystemsThinkingSkill(userId: $userId, answers: $answers) {
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
        understandingRelationships: 'a',
        holisticApproach: 'b',
        patternIdentification: 'b',
        feedbackLoops: 'c',
        systemAlteration: 'b',
        unintendedConsequences: 'b'
      }
    }
  end

  context 'when user has a systems thinking skill' do
    it 'creates a UsersSkill record' do
      expect { graphql_query(mutation, variables: variables) }.to change { UsersSkill.count }.by(1)
    end
     
    it 'returns a success' do
      expect(data['success']).to be_truthy
      expect(data['errors']).to be_empty
    end
  end

  context 'when user does not have a systems thinking skill' do
    let(:variables) do
      {
        userId: user.id,
        answers: {
          understandingRelationships: 'a',
          holisticApproach: 'c',
          patternIdentification: 'b',
          feedbackLoops: 'c',
          systemAlteration: 'c',
          unintendedConsequences: 'a'
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
          understandingRelationships: 'a',
          holisticApproach: 'b',
          patternIdentification: 'b',
          feedbackLoops: 'c',
          systemAlteration: 'b',
          unintendedConsequences: 'b'
        }
      }
    end

    it 'returns an error' do
      expect(data['success']).to be_falsey
      expect(data['errors']).to include('User not found')
    end
  end
end
