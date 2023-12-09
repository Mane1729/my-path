module Types
  class EmergingJobType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :industry, String, null: false
    field :description, String, null: false
  end
end
