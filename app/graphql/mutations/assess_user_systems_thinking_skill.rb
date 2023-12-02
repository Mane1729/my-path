module Mutations
  class AssessUserSystemsThinkingSkill < GraphQL::Schema::Mutation
    description "Assesses user's Systems Thinking skill based on a questionnaire"

    field :success, Boolean, null: false
    field :errors, [String], null: false

    argument :answers, Types::SystemsThinkingQuestionnaireInputType, required: true, 
                      description: 'Answers to the Systems Thinking questionnaire'

    def resolve(answers:)
      Commands::AssessUserSystemsThinkingSkill.call(user_id: context[:session][:user_id], answers:)
    end
  end
end
