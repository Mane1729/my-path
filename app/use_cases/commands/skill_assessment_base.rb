module Commands
  class SkillAssessmentBase
    def initialize(user_id:, answers:)
      @user_id = user_id
      @answers = answers
    end

    attr_reader :user_id, :answers

    def perform
      user = User.find_by(id: user_id)
      return error('User not found') if user.nil?

      skill_name, skill_check_method = skill_check_details
      if send(skill_check_method, answers)
        skill = Skill.find_by(name: skill_name)
        return error("#{skill_name} skill not found") if skill.nil?

        users_skill = UsersSkill.create(user: user, skill: skill)
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

    def skill_check_details
      raise NotImplementedError, 'Subclasses must implement skill_check_details'
    end
  end
end
