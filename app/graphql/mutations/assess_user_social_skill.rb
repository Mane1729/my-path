module Mutations
  class AssessUserSocialSkill < GraphQL::Schema::Mutation
    description "Assesses user's Social skill based on a questionnaire"

    field :success, Boolean, null: false
    field :errors, [String], null: false

    argument :answers, Types::SocialQuestionnaireInputType, required: true, 
                      description: 'Answers to the Social questionnaire'

    def resolve(answers:)
      Commands::AssessUserSocialSkill.call(user_id: context[:session][:user_id], answers:)
    end
  end
end
