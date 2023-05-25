class PagesController < ApplicationController
  def welcome
  end

  def questions
    render 'questions'
  end
end
