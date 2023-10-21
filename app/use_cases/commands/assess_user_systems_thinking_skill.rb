module Commands
  class AssessUserSystemsThinkingSkill
    extend Base

    def initialize(user_id:, answers:)
      @user_id = user_id
      @answers = answers
    end

    attr_reader :user_id, :answers

    def perform
      user = User.find_by(id: user_id)
      return error('User not found') if user.nil?

      if has_systems_thinking_skill(answers)
        systems_thinking_skill = Skill.find_by(name: "Systems thinking")
        return error('Systems thinking skill not found') if systems_thinking_skill.nil?

        users_skill = UsersSkill.create(user:, skill: systems_thinking_skill)
        return error(users_skill.errors.full_messages) unless users_skill.persisted?
      end
      
      success
    end

    private

    def success
      { success: true, errors: [] }
    end

    def error(message)
      { success: false, errors: [message].flatten }
    end

    def has_systems_thinking_skill(answers)
      b_answers_count = answers.values.count('b')
      b_answers_count > 3
    end
  end
end