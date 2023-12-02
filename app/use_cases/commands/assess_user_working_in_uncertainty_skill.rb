module Commands
  class AssessUserWorkingInUncertaintySkill < SkillAssessmentBase
    extend Base

    private

    def has_working_in_uncertainty_skill(answers)
      correct_answers = {
        first_step: 'b', 
        approach_to_divergent_opinions: 'c',
        handling_team_member_resignation: 'b',
        response_to_competitor_release: 'b'
      }

      correct_count = answers.to_h.count { |question, answer| correct_answers[question] == answer }
      correct_count > 2
    end

    def skill_check_details
      ["Working in uncertainty", :has_working_in_uncertainty_skill]
    end
  end
end
