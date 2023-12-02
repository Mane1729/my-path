require 'rails_helper'
require 'support/shared_examples/skill_assessment_command.rb'

RSpec.describe Commands::AssessUserWorkingInUncertaintySkill do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'Working in uncertainty') }

  let(:positive_answers) do
    {
      first_step: 'b', 
      approach_to_divergent_opinions: 'c',
      handling_team_member_resignation: 'a',
      response_to_competitor_release: 'b'
    }
  end

  let(:negative_answers) do
    {
      first_step: 'a', 
      approach_to_divergent_opinions: 'c',
      handling_team_member_resignation: 'd',
      response_to_competitor_release: 'a'
    }
  end

  it_behaves_like 'skill assessment command', 'Working in uncertainty'
end
