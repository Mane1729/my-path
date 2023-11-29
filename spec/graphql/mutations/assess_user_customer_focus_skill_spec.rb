require 'rails_helper'
require 'support/shared_examples/skill_assessment_mutation.rb'

RSpec.describe Mutations::AssessUserCustomerFocusSkill, type: :request do
  let!(:skill) { create(:skill, name: 'Customer focus') }

  let(:positive_variables) do
    {
      answers: {
        initialResponse: 'c',
        addressingEmotion: 'b',
        proposedSolution: 'a',
        handlingNegativePublicity: 'c',
        futureTrustAssurance: 'c'
      }
    }
  end

  let(:negative_variables) do
    {
      answers: {
        initialResponse: 'c',
        addressingEmotion: 'a',
        proposedSolution: 'b',
        handlingNegativePublicity: 'c',
        futureTrustAssurance: 'a'
      }
    }
  end

  it_behaves_like 'skill assessment mutation', 'assessUserCustomerFocusSkill', 'CustomerFocusQuestionnaireInput'
end
