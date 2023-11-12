require 'rails_helper'

RSpec.describe Commands::AssessUserCrossIndustryCommunicationSkill do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'Cross-industry communication') }
  let(:answers) do
    {
      data_scientist_question: 'b',
      architect_question: 'b',
      telecommunication_expert_question: 'a',
      public_health_official: 'b',
    }
  end

  subject(:result) do
    described_class.call(user_id: user.id, answers:)
  end

  describe '.call' do
    context 'when user has a cross-industry communication skill' do
      it 'creates a UsersSkill record' do
        expect { result }.to change { UsersSkill.count }.by(1)
      end

      it 'returns a success' do
        expect(result[:success]).to be true
        expect(result[:errors]).to be_empty
      end
    end

    context 'when user does not have a cross-industry communication skill' do
      let(:answers) do
        {
          data_scientist_question: 'c',
          architect_question: 'b',
          telecommunication_expert_question: 'a',
          public_health_official: 'c',
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

    context 'when cross-industry communication skill does not exist' do
      before { skill.destroy }

      it 'returns an error' do
        expect(result[:success]).to be false
        expect(result[:errors]).to include('Cross-industry communication skill not found')
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
