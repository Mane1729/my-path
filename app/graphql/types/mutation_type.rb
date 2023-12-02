module Types
  class MutationType < Types::BaseObject
    field :update_user_working_hours, mutation: Mutations::UpdateUserWorkingHours
    field :create_user, mutation: Mutations::CreateUser, description: 'Creates a user'
    field :assess_user_systems_thinking_skill, mutation: Mutations::AssessUserSystemsThinkingSkill, 
                                               description: "Assesses user's Systems Thinking skill based on a questionnaire"
    field :assess_user_project_management_skill, mutation: Mutations::AssessUserProjectManagementSkill, 
                                               description: "Assesses user's Project Management skill based on their answer to a specific question"
    field :assess_user_cross_industry_communication_skill, mutation: Mutations::AssessUserCrossIndustryCommunicationSkill, 
                                               description: "Assesses user's Cross-Industry Communication skill based on a questionnaire"
    field :assess_user_customer_focus_skill, mutation: Mutations::AssessUserCustomerFocusSkill, 
                                               description: "Assesses user's Customer Focus skill based on a questionnaire"
    field :assess_user_information_technology_skill, mutation: Mutations::AssessUserInformationTechnologySkill, 
                                               description: "Assesses user's IT skill based on a questionnaire"
    field :assess_user_social_skill, mutation: Mutations::AssessUserSocialSkill, 
                                               description: "Assesses user's Social skill based on a questionnaire"
    field :assess_user_lean_production_skill, mutation: Mutations::AssessUserLeanProductionSkill, 
                                               description: "Assesses user's Lean Production skill based on their response to a scenario question"
    field :assess_user_working_in_uncertainty_skill, mutation: Mutations::AssessUserWorkingInUncertaintySkill, 
                                               description: "Assesses user's Working In Uncertainty skill based on a questionnaire"
    field :assess_user_ecological_thinking_skill, mutation: Mutations::AssessUserEcologicalThinkingSkill, 
                                               description: "Assesses user's Ecological Thinking skill based on a questionnaire"
  end
end
