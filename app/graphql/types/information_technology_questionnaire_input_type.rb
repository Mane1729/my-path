module Types
  class InformationTechnologyQuestionnaireInputType < Types::BaseInputObject
    # Logical Questions
    argument :age_problem, FourOptionAnswerEnum, required: true
    argument :number_series_next, FourOptionAnswerEnum, required: true
    argument :sequence_next, FourOptionAnswerEnum, required: true
    argument :logical_deduction, FourOptionAnswerEnum, required: true
    argument :comparative_cost, FourOptionAnswerEnum, required: true

    # Technical Questions
    argument :ip_assignment_protocol, FourOptionAnswerEnum, required: true
    argument :directory_view_command, FourOptionAnswerEnum, required: true
    argument :volatile_memory_component, FourOptionAnswerEnum, required: true
    argument :hierarchical_data_structure, FourOptionAnswerEnum, required: true
    argument :web_page_fetch_protocol, FourOptionAnswerEnum, required: true
  end
end
