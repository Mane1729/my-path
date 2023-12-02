module Mutations
  class AssessUserCustomerFocusSkill < GraphQL::Schema::Mutation
    description "Assesses user's CustomerFocus skill based on a questionnaire"

    field :success, Boolean, null: false
    field :errors, [String], null: false

    argument :answers, Types::CustomerFocusQuestionnaireInputType, required: true, 
                      description: 'Answers to the Customer Focus questionnaire'

    def resolve(answers:)
      Commands::AssessUserCustomerFocusSkill.call(user_id: context[:session][:user_id], answers:)
    end
  end
end
