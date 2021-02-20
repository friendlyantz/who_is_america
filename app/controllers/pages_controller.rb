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

end
