module Commands
  class AssessUserCrossIndustryCommunicationSkill < SkillAssessmentBase
    extend Base

    private

    def has_cross_industry_communication_skill(answers)
      b_answers_count = answers.values.count('b')
      b_answers_count > 2
    end

    def skill_check_details
      ["Cross-industry communication", :has_cross_industry_communication_skill]
    end
  end
end
