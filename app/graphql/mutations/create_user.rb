module Mutations
  class CreateUser < Mutations::BaseMutation
    description 'Creates a new user'

    field :id, ID, null: true, description: 'ID of the created user'
    field :success, Boolean, null: false
    field :errors, [String], null: false

    def resolve
      user = User.create

      if user.persisted?
        { id: user.id, success: true, errors: [] }
      else
        { id: nil, success: false, errors: user.errors.full_messages }
      end
    end
  end
end
