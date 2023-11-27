module Commands
  class AssessUserCustomerFocusSkill
    extend Base

    def initialize(user_id:, answers:)
      @user_id = user_id
      @answers = answers
    end

    attr_reader :user_id, :answers

    def perform
      user = User.find_by(id: user_id)
      return error('User not found') if user.nil?

      if has_customer_focus_skill(answers)
        customer_focus_skill = Skill.find_by(name: "Customer focus")
        return error('Customer focus skill not found') if customer_focus_skill.nil?

        users_skill = UsersSkill.create(user:, skill: customer_focus_skill)
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

    def has_customer_focus_skill(answers)
      correct_answers = ["c", "b", "c", "b", "c"]

      correct_count = answers.values.each_with_index.count do |value, index|
        correct_answers[index] == value
      end
      correct_count > 2 
    end
  end
end