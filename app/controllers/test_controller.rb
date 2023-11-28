class TestController < ApplicationController
  def setup_session
    session[:user_id] = params[:user_id]
    render json: { status: 'session set' }
  end
end
