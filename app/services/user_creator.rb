class UserCreator < ApplicationService
  def initialize(user_params)
    @user_params = user_params
  end

  def call
    User.new(@user_params)
  end
end