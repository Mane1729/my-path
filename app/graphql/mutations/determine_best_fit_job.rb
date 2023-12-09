module Mutations
  class DetermineBestFitJob < GraphQL::Schema::Mutation
    description "Finds the best fitting job based on the user's skills and preferred industries"

    field :emerging_job, Types::EmergingJobType, null: true, description: 'The best fitting emerging job'
    field :lacking_skills, [Types::SkillType], null: true, description: 'List of skills lacking for the best fitting job'
    field :success, Boolean, null: false, description: 'Whether or not the operation was successful'
    field :errors, [String], null: false, description: 'List of errors encountered during the operation'

    argument :industries, [String], required: false, description: "List of preferred industries"

    def resolve(industries: [])
      Commands::DetermineBestFitJob.call(user_id: context[:session][:user_id], industries:)
    end
  end
end