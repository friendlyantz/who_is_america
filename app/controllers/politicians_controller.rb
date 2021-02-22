  class PoliticiansController < ApplicationController
  def index
    @politicians = Politician.all
    @locations = Location.all
  end

  def show
    @politician = Politician.find(params[:id]) 
  end

end
