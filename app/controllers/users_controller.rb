class UsersController < ApplicationController
  def predict_career
    @user = UserCreator.call(user_params)
    if @user.save
      career = CareerPredictor.call(@user)
      @user.update!(career: career)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:working_hours, :public_speaking_points, :self_learning, :extra_courses, :plays_games, :team_player,
      :introvert, :reading_writing_skills, :memory_capability, :interested_subject, :fav_book_genre, :behaviour, :salary_work, 
      :management_technical, :worker_type)
  end
end
