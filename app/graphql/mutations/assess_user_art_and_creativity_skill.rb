module Mutations
  class AssessUserArtAndCreativitySkill < GraphQL::Schema::Mutation
    description "Assesses user's Art and Creativity skill based on their answer to a specific question"

    field :success, Boolean, null: false
    field :errors, [String], null: false

    argument :idea_count, Integer, required: true, description: 'The count of creative ideas provided by the user'
    argument :answer, String, required: true, description: 'Answer to the Art and Creativity question'

    def resolve(idea_count:, answer:)
      Commands::AssessUserArtAndCreativitySkill.call(user_id: context[:session][:user_id], idea_count:, answer:)
    end
  end
end
