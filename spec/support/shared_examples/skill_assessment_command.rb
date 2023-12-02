RSpec.shared_examples 'skill assessment command' do |skill_name|
  let(:answers) { positive_answers }

  subject(:result) do
    described_class.call(user_id: user.id, answers:)
  end

  context "when user has a #{skill_name} skill" do
    it 'creates a UsersSkill record' do
      expect { result }.to change { UsersSkill.count }.by(1)
      expect(UsersSkill.exists?(user:, skill:)).to be true
    end

    it 'returns a success' do
      expect(result[:success]).to be true
      expect(result[:errors]).to be_empty
    end
  end

  context "when user does not have a #{skill_name} skill" do
    let(:answers) { negative_answers }

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

  context "when #{skill_name} skill does not exist" do
    before { skill.destroy }

    it 'returns an error' do
      expect(result[:success]).to be false
      expect(result[:errors]).to include("#{skill_name} skill not found")
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
