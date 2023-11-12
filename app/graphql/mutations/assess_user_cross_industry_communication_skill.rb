module Mutations
  class AssessUserCrossIndustryCommunicationSkill < GraphQL::Schema::Mutation
    description "Assesses user's Cross-industry communication skill based on a questionnaire"

    field :success, Boolean, null: false
    field :errors, [String], null: false

    argument :user_id, ID, required: true, description: 'ID of the user'
    argument :answers, Types::CrossIndustryCommunicationQuestionnaireInputType, required: true, 
                      description: 'Answers to the Cross-industry communication questionnaire'

    def resolve(user_id:, answers:)
      Commands::AssessUserCrossIndustryCommunicationSkill.call(user_id:, answers:)
    end
  end
end
