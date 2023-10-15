module Mutations
  class AssessUserSystemsThinkingSkill < GraphQL::Schema::Mutation
    description "Assesses user's Systems Thinking skill based on a questionnaire"

    field :success, Boolean, null: false
    field :errors, [String], null: false

    argument :user_id, ID, required: true, description: 'ID of the user'
    argument :answers, Types::SystemsThinkingQuestionnaireInputType, required: true, 
                      description: 'Answers to the Systems Thinking questionnaire'

    def resolve(user_id:, answers:)
      if has_systems_thinking_skill(answers)
        user = User.find(user_id)
        systems_thinking_skill = Skill.find_by(name: "Systems thinking")
        
        users_skill = UsersSkill.create(user: user, skill: systems_thinking_skill)
        if users_skill.persisted?
          { success: true, errors: [] }
        else
          { success: false, errors: users_skill.errors.full_messages }
        end
      else
        { success: true, errors: [] }
      end
    end

    private

    # Answers leaning towards option 'b' generally indicate a stronger ability of Systems Thinking 
    def has_systems_thinking_skill(answers)
      b_answers_count = answers.values.count('b')
      b_answers_count > 3
    end
  end
end
