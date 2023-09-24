module Types
  class MutationType < Types::BaseObject
    field :update_user_working_hours, mutation: Mutations::UpdateUserWorkingHours
  end
end
