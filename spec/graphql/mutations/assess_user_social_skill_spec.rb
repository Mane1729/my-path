require 'rails_helper'
require 'support/shared_examples/skill_assessment_mutation.rb'

RSpec.describe Mutations::AssessUserSocialSkill, type: :request do
  let!(:skill) { create(:skill, name: 'Social') }

  let(:positive_variables) do
    {
      answers: {
        teamConflict: 'c',
        newTeamMemberStruggling: 'a',
        sharingNegativeFeedback: 'c',
      }
    }
  end

  let(:negative_variables) do
    {
      answers: {
        teamConflict: 'a',
        newTeamMemberStruggling: 'b',
        sharingNegativeFeedback: 'd',
      }
    }
  end

  it_behaves_like 'skill assessment mutation', 'assessUserSocialSkill', 'SocialQuestionnaireInput'
end
