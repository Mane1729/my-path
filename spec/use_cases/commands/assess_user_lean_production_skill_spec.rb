require 'rails_helper'

RSpec.describe Commands::AssessUserLeanProductionSkill do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'Lean production') }
  let(:answer) { 'answer for lean production skill assessment question' }

  subject(:result) do
    described_class.call(user_id: user.id, answer:)
  end

  before do
    allow(Settings).to receive(:openai_api_enabled).and_return(true)
    allow_any_instance_of(described_class).to receive(:call_openai_api).and_return('yes') 
  end

  describe '.call' do
    context 'when user has a lean production skill' do
      it 'creates a UsersSkill record' do
        expect { result }.to change { UsersSkill.count }.by(1)
      end

      it 'returns a success' do
        expect(result[:success]).to be true
        expect(result[:errors]).to be_empty
      end
    end

    context 'when user does not have a lean production skill' do
      before { allow_any_instance_of(described_class).to receive(:call_openai_api).and_return('no')  }

      it 'does not create a UsersSkill record' do
        expect { result }.not_to change { UsersSkill.count }
      end

      it 'returns a success' do
        expect(result[:success]).to be true
        expect(result[:errors]).to be_empty
      end
    end

    context 'when OpenAI API is disabled' do
      before { allow(Settings).to receive(:openai_api_enabled).and_return(false) }

      it 'does not create a UsersSkill record' do
        expect { result }.not_to change { UsersSkill.count }
      end

      it 'returns a success' do
        expect(result[:success]).to be true
        expect(result[:errors]).to be_empty
      end
    end

    context 'when user does not exist' do
      it 'returns an error' do
        result = described_class.call(user_id: -1, answer:)

        expect(result[:success]).to be false
        expect(result[:errors]).to include('User not found')
      end
    end

    context 'when lean production does not exist' do
      before { skill.destroy }

      it 'returns an error' do
        expect(result[:success]).to be false
        expect(result[:errors]).to include('Lean production skill not found')
      end
    end

    context 'when unable to create UsersSkill record' do
      before do
        allow(UsersSkill).to receive(:create).and_return(double('UsersSkill', persisted?: false, errors: double(full_messages: ['Error'])))
      end

      it 'returns an error' do
        expect(result[:success]).to be false
        expect(result[:errors]).to include('Error')
      end
    end

    context 'when OpenAI API returns an invalid response' do
      before do
         allow_any_instance_of(described_class).to receive(:call_openai_api)
        .and_return('Based on the answer the user possesses excellent lean production skill') 
      end

      it 'returns an error' do
        expect(result[:success]).to be false
        expect(result[:errors]).to include('Error with OpenAI API')
      end
    end
  end
end
