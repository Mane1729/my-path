module Mutations
  class AssessUserCustomerFocusSkill < GraphQL::Schema::Mutation
    description "Assesses user's CustomerFocus skill based on a questionnaire"

    field :success, Boolean, null: false
    field :errors, [String], null: false

    argument :user_id, ID, required: true, description: 'ID of the user'
    argument :answers, Types::CustomerFocusQuestionnaireInputType, required: true, 
                      description: 'Answers to the Customer Focus questionnaire'

    def resolve(user_id:, answers:)
      Commands::AssessUserCustomerFocusSkill.call(user_id:, answers:)
    end
  end
end
