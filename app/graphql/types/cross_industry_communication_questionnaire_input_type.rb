module Types
  class CrossIndustryCommunicationQuestionnaireInputType < Types::BaseInputObject
    argument :data_scientist_question, MultipleChoiceAnswerEnum, required: true
    argument :architect_question, MultipleChoiceAnswerEnum, required: true
    argument :telecommunication_expert_question, MultipleChoiceAnswerEnum, required: true
    argument :public_health_official_question, MultipleChoiceAnswerEnum, required: true
  end
end
