module Mutations
  class AssessUserSystemsThinkingSkill < GraphQL::Schema::Mutation
    description "Assesses user's Systems Thinking skill based on a questionnaire"

    field :success, Boolean, null: false
    field :errors, [String], null: false

    argument :user_id, ID, required: true, description: 'ID of the user'
    argument :answers, Types::SystemsThinkingQuestionnaireInputType, required: true, 
                      description: 'Answers to the Systems Thinking questionnaire'

    def resolve(user_id:, answers:)
      Commands::AssessUserSystemsThinkingSkill.call(user_id:, answers:)
    end
  end
end
