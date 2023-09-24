class Mutations::UpdateUserWorkingHours < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :working_hours, Integer, required: true

  field :user, Types::UserType, null: false
  field :success, Boolean, null: false
  field :errors, [String], null: false

  def resolve(id:, working_hours:)
    user = User.find(id)

    if user.update(working_hours: working_hours)
      { user: user, success: true, errors: [] }
    else
      { user: nil, success: false, errors: record.errors.full_messages }
    end
  end
end