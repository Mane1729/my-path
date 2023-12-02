module Mutations
  class AssessUserCrossIndustryCommunicationSkill < GraphQL::Schema::Mutation
    description "Assesses user's Cross-Industry Communication skill based on a questionnaire"

    field :success, Boolean, null: false
    field :errors, [String], null: false

    argument :answers, Types::CrossIndustryCommunicationQuestionnaireInputType, required: true, 
                      description: 'Answers to the Cross-Industry Communication questionnaire'

    def resolve(answers:)
      Commands::AssessUserCrossIndustryCommunicationSkill.call(user_id: context[:session][:user_id], answers:)
    end
  end
end
