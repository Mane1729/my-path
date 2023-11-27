module Types
  class CrossIndustryCommunicationQuestionnaireInputType < Types::BaseInputObject
    argument :data_scientist_question, ThreeOptionAnswerEnum, required: true
    argument :architect_question, ThreeOptionAnswerEnum, required: true
    argument :telecommunication_expert_question, ThreeOptionAnswerEnum, required: true
    argument :public_health_official_question, ThreeOptionAnswerEnum, required: true
  end
end
