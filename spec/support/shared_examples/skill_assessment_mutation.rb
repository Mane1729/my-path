RSpec.shared_examples 'skill assessment mutation' do |mutation_name, input_type|
  let(:user) { create(:user) }
  let(:variables) { positive_variables }
  let(:data) { graphql_query(mutation, variables:)['data'][mutation_name] }
  let(:capitalized_mutation_name) { mutation_name[0].upcase + mutation_name[1..] }

  let(:mutation) do
    <<~GQL
      mutation #{capitalized_mutation_name}($answers: #{input_type}!) {
        #{mutation_name}(answers: $answers) {
          success
          errors
        }
      }
    GQL
  end

  before { post '/test_setup_session', params: { user_id: user.id } }

  context 'when user has the skill' do
    it 'creates a UsersSkill record' do
      expect { graphql_query(mutation, variables:) }.to change { UsersSkill.count }.by(1)
      expect(UsersSkill.exists?(user:, skill:)).to be true
    end

    it 'returns a success' do
      expect(data['success']).to be_truthy
      expect(data['errors']).to be_empty
    end
  end

  context 'when user does not have the skill' do
    let(:variables) { negative_variables }

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
