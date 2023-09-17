# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :working_hours, Integer, null: false
    field :public_speaking_points, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    # field :self_learning, Types::EnumType, null: false
    # field :extra_courses, Types::EnumType, null: false
    # field :plays_games, Types::EnumType, null: false
    # field :team_player, Types::EnumType, null: false
    # field :introvert, Types::EnumType, null: false
    # field :reading_writing_skills, Types::EnumType, null: false
    # field :memory_capability, Types::EnumType, null: false
    # field :interested_subject, Types::EnumType, null: false
    # field :fav_book_genre, Types::EnumType, null: false
    # field :behaviour, Types::EnumType, null: false
    # field :management_technical, Types::EnumType, null: false
    # field :salary_work, Types::EnumType, null: false
    # field :worker_type, Types::EnumType, null: false
    # field :career, Types::EnumType
  end
end
