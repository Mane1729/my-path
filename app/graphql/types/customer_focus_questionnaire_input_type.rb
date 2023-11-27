module Types
  class CustomerFocusQuestionnaireInputType < Types::BaseInputObject
    argument :initial_response, FourOptionAnswerEnum, required: true
    argument :addressing_emotion, FourOptionAnswerEnum, required: true
    argument :proposed_solution, FourOptionAnswerEnum, required: true
    argument :handling_negative_publicity, FourOptionAnswerEnum, required: true
    argument :future_trust_assurance, FourOptionAnswerEnum, required: true
  end
end
