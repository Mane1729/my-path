module Types
  class SocialQuestionnaireInputType < Types::BaseInputObject
    argument :team_conflict, FourOptionAnswerEnum, required: true
    argument :new_team_member_struggling, FourOptionAnswerEnum, required: true
    argument :sharing_negative_feedback, FourOptionAnswerEnum, required: true
  end
end
