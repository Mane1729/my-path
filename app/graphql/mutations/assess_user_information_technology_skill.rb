module Mutations
  class AssessUserInformationTechnologySkill < GraphQL::Schema::Mutation
    description "Assesses user's IT skill based on a questionnaire"

    field :success, Boolean, null: false
    field :errors, [String], null: false

    argument :answers, Types::InformationTechnologyQuestionnaireInputType, required: true, 
                      description: 'Answers to the IT questionnaire'

    def resolve(answers:)
      Commands::AssessUserInformationTechnologySkill.call(user_id: context[:session][:user_id], answers:)
    end
  end
end
