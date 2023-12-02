require 'rails_helper'
require 'support/shared_examples/skill_assessment_command.rb'

RSpec.describe Commands::AssessUserSocialSkill do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'Social') }

  let(:positive_answers) do
    {
      team_conflict: 'c',
      new_team_member_struggling: 'a',
      sharing_negative_feedback: 'c',
    }
  end

  let(:negative_answers) do
    {
      team_conflict: 'a',
      new_team_member_struggling: 'b',
      sharing_negative_feedback: 'd',
    }
  end

  it_behaves_like 'skill assessment command', 'Social'
end
