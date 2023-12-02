module Types
  class WorkingInUncertaintyQuestionnaireInputType < Types::BaseInputObject
    argument :first_step, FourOptionAnswerEnum, required: true
    argument :approach_to_divergent_opinions, FourOptionAnswerEnum, required: true
    argument :handling_team_member_resignation, FourOptionAnswerEnum, required: true
    argument :response_to_competitor_release, FourOptionAnswerEnum, required: true
  end
end
