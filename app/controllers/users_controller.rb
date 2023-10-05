require 'pycall/import'
include PyCall::Import
require 'json'


class UsersController < ApplicationController
  def result
    @user = User.find(session[:user_id])
    session[:user_id] = nil
    
    json_string = File.read('app/javascript/careers.json')
    @json_data = JSON.parse(json_string)
  
  end

  def predict_career
    @user = UserCreator.call(profile_params)
    if @user.save
      career = CareerPredictor.call(@user)
      @user.update!(career: career)
      session[:user_id] = @user.id
      redirect_to result_path, status: :moved_permanently
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:working_hours, :public_speaking_points, :self_learning, :extra_courses, :plays_games, :team_player,
      :introvert, :reading_writing_skills, :memory_capability, :interested_subject, :fav_book_genre, :behaviour, :salary_work, 
      :management_technical, :worker_type)
  end
end
