require 'rails_helper'

RSpec.describe Mutations::CreateUser, type: :request do
  let(:data) { graphql_query(mutation)['data']['createUser'] }

  def mutation
    <<~GQL
      mutation {
        createUser(input: {}){
          id
          success
          errors
        }
      }
    GQL
  end

  context 'when user is created successfully' do
    it 'creates a new user' do
      expect { graphql_query(mutation) }.to change { User.count }.by(1)
    end

    it 'returns a user id on successful creation' do
      expect(data['id']).not_to be_nil
      expect(data['success']).to be_truthy
      expect(data['errors']).to be_empty
    end
  end

  context 'when user creation failed due to an error' do
    it 'returns the error message' do
      allow_any_instance_of(User).to receive(:save).and_return(false)
      allow_any_instance_of(User).to receive_message_chain(:errors, :full_messages).and_return(['Error message'])

      expect(data['id']).to be_nil
      expect(data['success']).to be_falsey
      expect(data['errors']).to eq(['Error message'])
    end
  end
end
