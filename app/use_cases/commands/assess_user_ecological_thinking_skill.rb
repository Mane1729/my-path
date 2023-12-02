module Commands
  class AssessUserEcologicalThinkingSkill < SkillAssessmentBase
    extend Base

    private

    def has_ecological_thinking_skill(answers)
      correct_answers = {
        greenhouse_effect_contribution: 'c', 
        deforestation_causes: 'c',
        renewable_resource: 'd',
        plastic_pollutants_impact: 'c',
        water_scarcity_contributor: 'c'
      }

      correct_count = answers.to_h.count { |question, answer| correct_answers[question] == answer }
      correct_count > 3
    end

    def skill_check_details
      ["Ecological thinking", :has_ecological_thinking_skill]
    end
  end
end
