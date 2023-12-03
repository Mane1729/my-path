require 'rails_helper'

RSpec.describe Mutations::AssessUserMultilingualismMulticulturalismSkill, type: :request do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'Multilingualism / Multiculturalism') }
  let(:data) { graphql_query(mutation, variables: variables)['data']['assessUserMultilingualismMulticulturalismSkill'] }

  let(:mutation) do
    <<~GQL
      mutation AssessUserMultilingualismMulticulturalismSkill($multilingualismCorrectCount: Int!, $multiculturalismAnswers: MulticulturalismQuestionnaireInput!) {
        assessUserMultilingualismMulticulturalismSkill(multilingualismCorrectCount: $multilingualismCorrectCount, multiculturalismAnswers: $multiculturalismAnswers) {
          success
          errors
        }
      }
    GQL
  end

  let(:variables) do
    {
      multilingualismCorrectCount: 9,
      multiculturalismAnswers: {
        sushi: 'c', 
        paella: 'a',
        colosseum: 'b',
        sydneyOperaHouse: 'c',
        kilt: 'a',
        hanbok: 'd'
      }
    }
  end

  before { post '/test_setup_session', params: { user_id: user.id } }

  context 'when user has the skill' do
    it 'creates a UsersSkill record' do
      # binding.pry
      expect { graphql_query(mutation, variables:) }.to change { UsersSkill.count }.by(1)
      expect(UsersSkill.exists?(user:, skill:)).to be true
    end

    it 'returns a success' do
      expect(data['success']).to be_truthy
      expect(data['errors']).to be_empty
    end
  end

  context 'when user does not have the skill' do
    let(:variables) do
      {
        multilingualismCorrectCount: 4,
        multiculturalismAnswers: {
          sushi: 'd', 
          paella: 'a',
          colosseum: 'c',
          sydneyOperaHouse: 'c',
          kilt: 'a',
          hanbok: 'd'
        }
      }
    end

    it 'does not create a UsersSkill record and returns a success' do
      expect { graphql_query(mutation, variables:) }.not_to change { UsersSkill.count }
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
