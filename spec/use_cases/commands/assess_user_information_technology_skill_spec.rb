require 'rails_helper'
require 'support/shared_examples/skill_assessment_command.rb'

RSpec.describe Commands::AssessUserInformationTechnologySkill do
  let(:user) { create(:user) }
  let!(:skill) { create(:skill, name: 'IT') }

  let(:positive_answers) do
    {
      age_problem: 'a', 
      number_seriesNext: 'c',
      sequence_next: 'b',
      logical_deduction: 'c',
      comparative_cost: 'b',
      ip_assignment_protocol: 'b',
      directory_view_command: 'd',
      volatile_memory_component: 'a', 
      hierarchical_data_structure: 'c',
      web_page_fetch_protocol: 'b'
    }
  end

  let(:negative_answers) do
    {
      age_problem: 'b', 
      number_series_next: 'd',
      sequence_next: 'b',
      logical_deduction: 'c',
      comparative_cost: 'a',
      ip_assignmentprotocol: 'b',
      directory_view_command: 'd',
      volatile_memory_component: 'a', 
      hierarchical_data_structure: 'c',
      web_page_fetch_protocol: 'b'
    }
  end

  it_behaves_like 'skill assessment command', 'IT'
end
