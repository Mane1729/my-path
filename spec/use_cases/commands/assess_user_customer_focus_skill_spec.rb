require 'rails_helper'

RSpec.describe Commands::AssessUserCustomerFocusSkill do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'Customer focus') }
  let(:answers) do
    {
      initialResponse: 'c',
      addressingEmotion: 'b',
      proposedSolution: 'a',
      handlingNegativePublicity: 'b',
      futureTrustAssurance: 'a'
    }
  end

  subject(:result) do
    described_class.call(user_id: user.id, answers:)
  end

  describe '.call' do
    context 'when user has a customer focus skill' do
      it 'creates a UsersSkill record' do
        # TODO: Check for the right skill (same for other specs)
        expect { result }.to change { UsersSkill.count }.by(1)
      end

      it 'returns a success' do
        expect(result[:success]).to be true
        expect(result[:errors]).to be_empty
      end
    end

    context 'when user does not have a customer focus skill' do
      let(:answers) do
        {
          initialResponse: 'b',
          addressingEmotion: 'b',
          proposedSolution: 'a',
          handlingNegativePublicity: 'c',
          futureTrustAssurance: 'a'
        }
      end

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
        result = described_class.call(user_id: -1, answers:)

        expect(result[:success]).to be false
        expect(result[:errors]).to include('User not found')
      end
    end

    context 'when customer focus skill does not exist' do
      before { skill.destroy }

      it 'returns an error' do
        expect(result[:success]).to be false
        expect(result[:errors]).to include('Customer focus skill not found')
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
  end
end
