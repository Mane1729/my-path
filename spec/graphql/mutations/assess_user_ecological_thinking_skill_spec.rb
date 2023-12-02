require 'rails_helper'
require 'support/shared_examples/skill_assessment_mutation.rb'

RSpec.describe Mutations::AssessUserEcologicalThinkingSkill, type: :request do
  let!(:skill) { create(:skill, name: 'Ecological thinking') }

  let(:positive_variables) do
    {
      answers: {
        greenhouseEffectContribution: 'c', 
        deforestationCauses: 'c',
        renewableResource: 'd',
        plasticPollutantsImpact: 'a',
        waterScarcityContributor: 'c'
      }
    }
  end

  let(:negative_variables) do
    {
      answers: {
        greenhouseEffectContribution: 'b', 
        deforestationCauses: 'c',
        renewableResource: 'd',
        plasticPollutantsImpact: 'a',
        waterScarcityContributor: 'b'
      }
    }
  end

  it_behaves_like 'skill assessment mutation', 'assessUserEcologicalThinkingSkill', 'EcologicalThinkingQuestionnaireInput'
end
