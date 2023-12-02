module Types
  class SystemsThinkingQuestionnaireInputType < Types::BaseInputObject
    argument :understanding_relationships, ThreeOptionAnswerEnum, required: true
    argument :holistic_approach, ThreeOptionAnswerEnum, required: true
    argument :pattern_identification, ThreeOptionAnswerEnum, required: true
    argument :feedback_loops, ThreeOptionAnswerEnum, required: true
    argument :system_alteration, ThreeOptionAnswerEnum, required: true
    argument :unintended_consequences, ThreeOptionAnswerEnum, required: true
  end
end
