require 'rails_helper'
require 'support/shared_examples/skill_assessment_mutation.rb'

RSpec.describe Mutations::AssessUserSystemsThinkingSkill, type: :request do
  let!(:skill) { create(:skill, name: 'Systems thinking') }

  let(:positive_variables) do
    {
      answers: {
        understandingRelationships: 'a',
        holisticApproach: 'b',
        patternIdentification: 'b',
        feedbackLoops: 'c',
        systemAlteration: 'b',
        unintendedConsequences: 'b'
      }
    }
  end

  let(:negative_variables) do
    {
      answers: {
        understandingRelationships: 'a',
        holisticApproach: 'c',
        patternIdentification: 'b',
        feedbackLoops: 'c',
        systemAlteration: 'c',
        unintendedConsequences: 'a'
      }
    }
  end

  it_behaves_like 'skill assessment mutation', 'assessUserSystemsThinkingSkill', 'SystemsThinkingQuestionnaireInput'
end
