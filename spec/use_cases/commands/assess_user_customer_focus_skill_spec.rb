require 'rails_helper'
require 'support/shared_examples/skill_assessment_command.rb'

RSpec.describe Commands::AssessUserCustomerFocusSkill do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'Customer focus') }

  let(:positive_answers) do
    {
      initialResponse: 'c',
      addressingEmotion: 'b',
      proposedSolution: 'a',
      handlingNegativePublicity: 'b',
      futureTrustAssurance: 'a'
    }
  end

  let(:negative_answers) do
    {
      initialResponse: 'b',
      addressingEmotion: 'b',
      proposedSolution: 'a',
      handlingNegativePublicity: 'c',
      futureTrustAssurance: 'a'
    }
  end

  it_behaves_like 'skill assessment command', 'Customer focus'
end
