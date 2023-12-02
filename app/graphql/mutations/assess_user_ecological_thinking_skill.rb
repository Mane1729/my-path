module Mutations
  class AssessUserEcologicalThinkingSkill < GraphQL::Schema::Mutation
    description "Assesses user's Ecological Thinking skill based on a questionnaire"

    field :success, Boolean, null: false
    field :errors, [String], null: false

    argument :answers, Types::EcologicalThinkingQuestionnaireInputType, required: true, 
                      description: 'Answers to the Ecological Thinking questionnaire'

    def resolve(answers:)
      Commands::AssessUserEcologicalThinkingSkill.call(user_id: context[:session][:user_id], answers:)
    end
  end
end
