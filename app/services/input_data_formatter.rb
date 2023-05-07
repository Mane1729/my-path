class InputDataFormatter < ApplicationService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    {
      'Extra-courses did': [user.extra_courses],
      'Gentle or Tuff behaviour?': [user.behaviour],
      'Hours working per day': [user.working_hours],
      'Interested Type of Books': [user.fav_book_genre],
      'Interested subjects': [user.interested_subject],
      'Introvert': [user.introvert],
      'Management or Technical': [user.management_technical],
      'Salary/work': [user.salary_work],
      'hard/smart worker': [user.worker_type],
      'interested in games': [user.plays_games],
      'memory capability score': [user.memory_capability],
      'public speaking points': [user.public_speaking_points],
      'reading and writing skills': [user.reading_writing_skills],
      'self-learning capability?': [user.self_learning],
      'worked in teams ever?': [user.team_player]
    }
  end
end