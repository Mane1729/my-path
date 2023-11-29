require 'rails_helper'

RSpec.describe Commands::AssessUserInformationTechnologySkill do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'IT') }
  let(:answers) do
    {
      age_problem: 'a', 
      number_seriesNext: 'c',
      sequence_next: 'b',
      logical_deduction: 'c',
      comparative_cost: 'b',
      ip_assignment_protocol: 'b',
      directory_view_command: 'd',
      volatile_memory_component: 'a', 
      hierarchical_data_structure: 'c',
      web_page_fetch_protocol: 'b'
    }
  end

  subject(:result) do
    described_class.call(user_id: user.id, answers:)
  end

  describe '.call' do
    context 'when user has an IT skill' do
      it 'creates a UsersSkill record' do
        expect { result }.to change { UsersSkill.count }.by(1)
      end

      it 'returns a success' do
        expect(result[:success]).to be true
        expect(result[:errors]).to be_empty
      end
    end

    context 'when user does not have an IT skill' do
      let(:answers) do
        {
          age_problem: 'b', 
          number_series_next: 'd',
          sequence_next: 'b',
          logical_deduction: 'c',
          comparative_cost: 'a',
          ip_assignmentprotocol: 'b',
          directory_view_command: 'd',
          volatile_memory_component: 'a', 
          hierarchical_data_structure: 'c',
          web_page_fetch_protocol: 'b'
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

    context 'when IT skill does not exist' do
      before { skill.destroy }

      it 'returns an error' do
        expect(result[:success]).to be false
        expect(result[:errors]).to include('IT skill not found')
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
