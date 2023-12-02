require 'rails_helper'
require 'support/shared_examples/skill_assessment_mutation.rb'

RSpec.describe Mutations::AssessUserCrossIndustryCommunicationSkill, type: :request do
  let!(:skill) { create(:skill, name: 'Cross-industry communication') }

  let(:positive_variables) do
    {
      answers: {
        dataScientistQuestion: 'b',
        architectQuestion: 'b',
        telecommunicationExpertQuestion: 'a',
        publicHealthOfficialQuestion: 'b'
      }
    }
  end

  let(:negative_variables) do
    {
      answers: {
        dataScientistQuestion: 'c',
        architectQuestion: 'b',
        telecommunicationExpertQuestion: 'a',
        publicHealthOfficialQuestion: 'c'
      }
    }
  end

  it_behaves_like 'skill assessment mutation', 'assessUserCrossIndustryCommunicationSkill', 'CrossIndustryCommunicationQuestionnaireInput'
end
