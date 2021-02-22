  class PoliticiansController < ApplicationController
  def index
    @politicians = Politician.all
    @locations = Location.all
  end

  def show
    find_politician
  end
  
  private
  
  def find_politician
    @politician = Politician.find(params[:id]) 
  end
  
  # def politician_params
  #   params.require(:politician).permit(:first_name, :last_name)    
  # end

end
