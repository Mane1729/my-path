module Commands
  class AssessUserSystemsThinkingSkill < SkillAssessmentBase
    extend Base

    private

    def has_systems_thinking_skill(answers)
      b_answers_count = answers.values.count('b')
      b_answers_count > 3
    end

    def skill_check_details
      ["Systems thinking", :has_systems_thinking_skill]
    end
  end
end
