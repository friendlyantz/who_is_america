  class PoliticiansController < ApplicationController
  def index
    @politicians = Politician.all
    @locations = Location.all
  end

  def show
    find_politician
  end
<<<<<<< HEAD
  
  private
  
  def find_politician
    @politician = Politician.find(params[:id]) 
  end
  
  # def politician_params
  #   params.require(:politician).permit(:first_name, :last_name)    
  # end
=======
>>>>>>> 5d6b991f62c8b486fee6acb485b79c0abdd2da75

end
