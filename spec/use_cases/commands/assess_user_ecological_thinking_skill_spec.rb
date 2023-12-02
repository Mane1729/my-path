require 'rails_helper'
require 'support/shared_examples/skill_assessment_command.rb'

RSpec.describe Commands::AssessUserEcologicalThinkingSkill do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'Ecological thinking') }

  let(:positive_answers) do
    {
      greenhouse_effect_contribution: 'c', 
      deforestation_causes: 'c',
      renewable_resource: 'd',
      plastic_pollutants_impact: 'c',
      water_scarcity_contributor: 'b'
    }
  end

  let(:negative_answers) do
    {
      greenhouse_effect_contribution: 'b', 
      deforestation_causes: 'a',
      renewable_resource: 'd',
      plastic_pollutants_impact: 'c',
      water_scarcity_contributor: 'b'
    }
  end

  it_behaves_like 'skill assessment command', 'Ecological thinking'
end
