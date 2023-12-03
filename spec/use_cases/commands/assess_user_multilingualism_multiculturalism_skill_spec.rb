require 'rails_helper'

RSpec.describe Commands::AssessUserMultilingualismMulticulturalismSkill do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'Multilingualism / Multiculturalism') }
  let(:multilingualism_correct_count) { 9 }
  let(:multiculturalism_answers) do
    {
      sushi: 'c', 
      paella: 'a',
      colosseum: 'b',
      sydney_opera_house: 'c',
      kilt: 'a',
      hanbok: 'd'
    }
  end

  subject(:result) do
    described_class.call(user_id: user.id, multilingualism_correct_count:, multiculturalism_answers:)
  end

  context "when user has a Multilingualism / Multiculturalism skill" do
    it 'creates a UsersSkill record' do
      expect { result }.to change { UsersSkill.count }.by(1)
      expect(UsersSkill.exists?(user:, skill:)).to be true
    end

    it 'returns a success' do
      expect(result[:success]).to be true
      expect(result[:errors]).to be_empty
    end
  end

  context "when user does not have a Multilingualism skill" do
    let(:multilingualism_correct_count) { 4 }

    it 'does not create a UsersSkill record' do
      expect { result }.not_to change { UsersSkill.count }
    end

    it 'returns a success' do
      expect(result[:success]).to be true
      expect(result[:errors]).to be_empty
    end
  end

  context "when user does not have a Multiculturalism skill" do
    let(:multiculturalism_answers) do
      {
        sushi: 'd', 
        paella: 'a',
        colosseum: 'b',
        sydney_opera_house: 'c',
        kilt: 'c',
        hanbok: 'd'
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
      result = described_class.call(user_id: -1, multilingualism_correct_count:, multiculturalism_answers:)
      expect(result[:success]).to be false
      expect(result[:errors]).to include('User not found')
    end
  end

  context "when Multilingualism / Multiculturalism skill does not exist" do
    before { skill.destroy }

    it 'returns an error' do
      expect(result[:success]).to be false
      expect(result[:errors]).to include("Multilingualism / Multiculturalism skill not found")
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
