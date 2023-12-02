require 'rails_helper'
require 'support/shared_examples/skill_assessment_command.rb'

RSpec.describe Commands::AssessUserCrossIndustryCommunicationSkill do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'Cross-industry communication') }

  let(:positive_answers) do
    {
      data_scientist_question: 'b',
      architect_question: 'b',
      telecommunication_expert_question: 'a',
      public_health_official: 'b'
    }
  end

  let(:negative_answers) do
    {
      data_scientist_question: 'c',
      architect_question: 'b',
      telecommunication_expert_question: 'a',
      public_health_official: 'c'
    }
  end

  it_behaves_like 'skill assessment command', 'Cross-industry communication'
end
