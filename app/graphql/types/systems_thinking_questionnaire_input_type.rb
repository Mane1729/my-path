module Types
  class SystemsThinkingQuestionnaireInputType < Types::BaseInputObject
    argument :understanding_relationships, MultipleChoiceAnswerEnum, required: true
    argument :holistic_approach, MultipleChoiceAnswerEnum, required: true
    argument :pattern_identification, MultipleChoiceAnswerEnum, required: true
    argument :feedback_loops, MultipleChoiceAnswerEnum, required: true
    argument :system_alteration, MultipleChoiceAnswerEnum, required: true
    argument :unintended_consequences, MultipleChoiceAnswerEnum, required: true
  end
end
