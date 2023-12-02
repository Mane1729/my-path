require 'rails_helper'
require 'support/shared_examples/skill_assessment_mutation.rb'

RSpec.describe Mutations::AssessUserInformationTechnologySkill, type: :request do
  let!(:skill) { create(:skill, name: 'IT') }

  let(:positive_variables) do
    {
      answers: {
        ageProblem: 'a', 
        numberSeriesNext: 'c',
        sequenceNext: 'b',
        logicalDeduction: 'c',
        comparativeCost: 'b',
        ipAssignmentProtocol: 'b',
        directoryViewCommand: 'd',
        volatileMemoryComponent: 'a', 
        hierarchicalDataStructure: 'c',
        webPageFetchProtocol: 'b'
      }
    }
  end

  let(:negative_variables) do
    {
      answers: {
        ageProblem: 'b', 
        numberSeriesNext: 'd',
        sequenceNext: 'b',
        logicalDeduction: 'c',
        comparativeCost: 'a',
        ipAssignmentProtocol: 'b',
        directoryViewCommand: 'd',
        volatileMemoryComponent: 'a', 
        hierarchicalDataStructure: 'c',
        webPageFetchProtocol: 'b'
      }
    }
  end

  it_behaves_like 'skill assessment mutation', 'assessUserInformationTechnologySkill', 'InformationTechnologyQuestionnaireInput'
end
