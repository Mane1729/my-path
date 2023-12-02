module Mutations
  class AssessUserProjectManagementSkill < GraphQL::Schema::Mutation
    description "Assesses user's Project Management skill based on their answer to a specific question"

    field :success, Boolean, null: false
    field :errors, [String], null: false

    argument :answer, String, required: true, description: 'Answer to the Project Management question'

    def resolve(answer:)
      Commands::AssessUserProjectManagementSkill.call(user_id: context[:session][:user_id], answer:)
    end
  end
end
