module Commands
  class AssessUserCustomerFocusSkill < SkillAssessmentBase
    extend Base

    private

    def has_customer_focus_skill(answers)
      correct_answers = ["c", "b", "c", "b", "c"]

      correct_count = answers.values.each_with_index.count do |value, index|
        correct_answers[index] == value
      end
      correct_count > 2 
    end

    def skill_check_details
      ["Customer focus", :has_customer_focus_skill]
    end
  end
end
