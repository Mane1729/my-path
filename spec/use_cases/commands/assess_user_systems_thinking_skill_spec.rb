require 'rails_helper'
require 'support/shared_examples/skill_assessment_command.rb'

RSpec.describe Commands::AssessUserSystemsThinkingSkill do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'Systems thinking') }

  let(:positive_answers) do
    {
      understandingRelationships: 'a',
      holisticApproach: 'b',
      patternIdentification: 'b',
      feedbackLoops: 'c',
      systemAlteration: 'b',
      unintendedConsequences: 'b'
    }
  end

  let(:negative_answers) do
    {
      understandingRelationships: 'a',
      holisticApproach: 'c',
      patternIdentification: 'b',
      feedbackLoops: 'c',
      systemAlteration: 'c',
      unintendedConsequences: 'a'
    }
  end

  it_behaves_like 'skill assessment command', 'Systems thinking'
end
