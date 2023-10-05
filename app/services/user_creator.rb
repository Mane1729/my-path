class UserCreator < ApplicationService
  def initialize(profile_params)
    @profile_params = profile_params
  end

  def call
    user = User.new
    user.build_profile(@profile_params)
    user
  end
end