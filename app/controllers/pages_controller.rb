class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :welcome]
  
  def welcome
    @locations = Location.all
    if user_signed_in?
      render 'home'
    end
  end

  def home
    @locations = Location.all
  end

  def my_account
    @user = current_user
  end
  
  def contribute
    @user = current_user
  end
  
  def quiz
    @user = current_user
    not_voted_quotes = Quote.all - current_user.votes.map(&:quote)
    @random_not_voted_quote = not_voted_quotes.sample
  end
  
end
