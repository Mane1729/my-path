module Mutations
  class AssessUserMultilingualismMulticulturalismSkill < GraphQL::Schema::Mutation
    description "Assesses user's Multilingualism / Multiculturalism skill based on a questionnaire"

    field :success, Boolean, null: false
    field :errors, [String], null: false

    argument :multilingualism_correct_count, Integer, required: true, 
                                              description: 'The number of correct answers to multilingualism assessment'
    argument :multiculturalism_answers, Types::MulticulturalismQuestionnaireInputType, required: true, 
                                        description: 'Answers to the Multiculturalism questionnaire'

    def resolve(multilingualism_correct_count:, multiculturalism_answers:)
      Commands::AssessUserMultilingualismMulticulturalismSkill.call(user_id: context[:session][:user_id], multilingualism_correct_count:, multiculturalism_answers:)
    end
  end
end
