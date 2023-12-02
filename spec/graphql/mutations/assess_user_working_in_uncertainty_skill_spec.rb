require 'rails_helper'
require 'support/shared_examples/skill_assessment_mutation.rb'

RSpec.describe Mutations::AssessUserWorkingInUncertaintySkill, type: :request do
  let!(:skill) { create(:skill, name: 'Working in uncertainty') }

  let(:positive_variables) do
    {
      answers: {
        firstStep: 'b', 
        approachToDivergentOpinions: 'c',
        handlingTeamMemberResignation: 'a',
        responseToCompetitorRelease: 'b'
      }
    }
  end

  let(:negative_variables) do
    {
      answers: {
        firstStep: 'a', 
        approachToDivergentOpinions: 'c',
        handlingTeamMemberResignation: 'a',
        responseToCompetitorRelease: 'd'
      }
    }
  end

  it_behaves_like 'skill assessment mutation', 'assessUserWorkingInUncertaintySkill', 'WorkingInUncertaintyQuestionnaireInput'
end
