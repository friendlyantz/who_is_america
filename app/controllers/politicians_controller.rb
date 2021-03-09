  class PoliticiansController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @politicians = Politician.all
    @locations = Location.all
  end

  def show
    find_politician
  end

  def new
    redirect_to home_path if current_user.permissions != "admin"
    @politician = Politician.new
    
  end
  
  def create
    redirect_to home_path if current_user.permissions != "admin"
    @politician = Politician.new(politician_params)
    if @politician.save
      flash[:notice] = 'Object successfully created'
      redirect_to politician_path(@politician)
    else
      flash[:alert] = 'Something went wrong'
      render 'new'
    end
  end
  
  def edit
    redirect_to home_path if current_user.permissions != "admin"
    @politician = Politician.find(params[:id])
  end
  
  def update
    redirect_to home_path if current_user.permissions != "admin"
    @politician = Politician.find(params[:id])
    if @politician.update(politician_params)
      flash[:notice] = 'Object successfully created'
      redirect_to politician_path(@politician)
    else
      flash[:alert] = 'Something went wrong'
      render 'edit'
    end
  end
  
  private
  
  def find_politician
    @politician = Politician.find(params[:id]) 
  end
  
  def politician_params
    params.require(:politician).permit(:first_name, :last_name, :party, :location_id,)    
  end

end
