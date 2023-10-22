require 'rails_helper'

RSpec.describe Mutations::AssessUserProjectManagementSkill, type: :request do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'Project management') }
  let(:data) { graphql_query(mutation, variables: variables)['data']['assessUserProjectManagementSkill'] }

  let(:mutation) do
    <<~GQL
      mutation AssessUserProjectManagemenSkill($userId: ID!, $answer: String!) {
        assessUserProjectManagementSkill(userId: $userId, answer: $answer) {
          success
          errors
        }
      }
    GQL
  end

  context 'when passing valid input' do
    let(:variables) do
      {
        userId: user.id,
        answer: 'answer for project management skill assessment question'
      }
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
        answer: 'valid answer indicating project management skill'
      }
    end

    it 'returns an error' do
      expect(data['success']).to be_falsey
      expect(data['errors']).to include('User not found')
    end
  end
end
