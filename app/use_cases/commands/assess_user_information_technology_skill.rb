module Commands
  class AssessUserInformationTechnologySkill
    extend Base

    def initialize(user_id:, answers:)
      @user_id = user_id
      @answers = answers
    end

    attr_reader :user_id, :answers

    def perform
      user = User.find_by(id: user_id)
      return error('User not found') if user.nil?

      if has_information_technology_skill(answers)
        information_technology_skill = Skill.find_by(name: "IT")
        return error('IT skill not found') if information_technology_skill.nil?

        users_skill = UsersSkill.create(user:, skill: information_technology_skill)
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

    def has_information_technology_skill(answers)
      # Correct answers for logical questions
      correct_answers_logical = {
        age_problem: 'a', 
        number_series_next: 'c',
        sequence_next: 'a',
        logical_deduction: 'c',
        comparative_cost: 'b'
      }

      # Correct answers for technical questions
      correct_answers_technical = {
        ip_assignment_protocol: 'b',
        directory_view_command: 'd',
        volatile_memory_component: 'c', 
        hierarchical_data_structure: 'c',
        web_page_fetch_protocol: 'b'
      }
      
      logical_keys = [:age_problem, :number_series_next, :sequence_next, :logical_deduction, :comparative_cost]
      technical_keys = [:ip_assignment_protocol, :directory_view_command, :volatile_memory_component, :hierarchical_data_structure, :web_page_fetch_protocol]

      correct_count_logical = count_correct_answers(answers.to_h.slice(*logical_keys), correct_answers_logical)
      correct_count_technical = count_correct_answers(answers.to_h.slice(*technical_keys), correct_answers_technical)

      correct_count_logical > 2 && correct_count_technical > 2
    end

    def count_correct_answers(user_answers, correct_answers)
      user_answers.count { |question, answer| correct_answers[question] == answer }
    end
  end
end
