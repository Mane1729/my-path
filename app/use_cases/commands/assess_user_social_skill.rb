module Commands
  class AssessUserSocialSkill < SkillAssessmentBase
    extend Base

    private

    def has_social_skill(answers)
      scoring = {
        team_conflict: {'a' => 1, 'b' => 3, 'c' => 4, 'd' => 2},
        new_team_member_struggling: {'a' => 4, 'b' => 1, 'c' => 3, 'd' => 2},
        sharing_negative_feedback: {'a' => 2, 'b' => 4, 'c' => 3, 'd' => 1}
      }

      total_score = answers.to_h.sum { |key, value| scoring[key][value] }
      total_score > 8
    end

    def skill_check_details
      ["Social", :has_social_skill]
    end
  end
end
