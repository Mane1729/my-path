module Mutations
  class AssessUserLeanProductionSkill < GraphQL::Schema::Mutation
    description "Assesses user's Lean Production skill based on their response to a scenario question"

    field :success, Boolean, null: false
    field :errors, [String], null: false

    argument :answer, String, required: true, description: 'Answer to the Lean Production question'

    def resolve(answer:)
      Commands::AssessUserLeanProductionSkill.call(user_id: context[:session][:user_id], answer:)
    end
  end
end
