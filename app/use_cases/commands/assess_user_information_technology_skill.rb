module Commands
  class AssessUserInformationTechnologySkill < SkillAssessmentBase
    extend Base

    private

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

    def skill_check_details
      ["IT", :has_information_technology_skill]
    end
  end
end
