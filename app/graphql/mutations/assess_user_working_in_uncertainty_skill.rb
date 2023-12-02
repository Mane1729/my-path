module Mutations
  class AssessUserWorkingInUncertaintySkill < GraphQL::Schema::Mutation
    description "Assesses user's Working In Uncertainty skill based on a questionnaire"

    field :success, Boolean, null: false
    field :errors, [String], null: false

    argument :answers, Types::WorkingInUncertaintyQuestionnaireInputType, required: true, 
                      description: 'Answers to the Working In Uncertainty questionnaire'

    def resolve(answers:)
      Commands::AssessUserWorkingInUncertaintySkill.call(user_id: context[:session][:user_id], answers:)
    end
  end
end
