module Types
  class MutationType < Types::BaseObject
    field :update_user_working_hours, mutation: Mutations::UpdateUserWorkingHours
    field :create_user, mutation: Mutations::CreateUser, description: 'Creates a user'
    field :assess_user_systems_thinking_skill, mutation: Mutations::AssessUserSystemsThinkingSkill, 
                                               description: "Assesses user's Systems Thinking skill based on a questionnaire"
    field :assess_user_project_management_skill, mutation: Mutations::AssessUserProjectManagementSkill, 
                                               description: "Assesses user's Project Management skill based on their answer to a specific question"
  end
end
