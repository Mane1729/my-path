module Types
  class EcologicalThinkingQuestionnaireInputType < Types::BaseInputObject
    argument :greenhouse_effect_contribution, FourOptionAnswerEnum, required: true
    argument :deforestation_causes, FourOptionAnswerEnum, required: true
    argument :renewable_resource, FourOptionAnswerEnum, required: true
    argument :plastic_pollutants_impact, FourOptionAnswerEnum, required: true
    argument :water_scarcity_contributor, FourOptionAnswerEnum, required: true
  end
end
