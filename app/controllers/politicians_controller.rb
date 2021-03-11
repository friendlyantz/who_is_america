  class PoliticiansController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    # @politicians = Politician.all
    @politicians = policy_scope(Politician)
    @locations = Location.all
  end
  
  def show
    find_politician
    @politicians = policy_scope(Politician)
  end

  def new
    @politician = Politician.new
    authorize @politician
    
  end
  
  def create
    @politician = Politician.new(politician_params)
    authorize @politician
    if @politician.save
      flash[:notice] = 'Object successfully created'
      redirect_to politician_path(@politician)
    else
      flash[:alert] = 'Something went wrong'
      render 'new'
    end
  end
  
  def edit
    @politician = Politician.find(params[:id])
    authorize @politician
  end
  
  def update
    @politician = Politician.find(params[:id])
    authorize @politician
    if @politician.update(politician_params)
      flash[:notice] = 'Object successfully update'
      redirect_to politician_path(@politician)
    else
      flash[:alert] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    @politician = Politician.find(params[:id])
    authorize @politician
    if @politician.destroy
      flash[:notice] = 'Object successfully destroyed'
      redirect_to politicians_path
    else
      flash[:alert] = 'Something went wrong'
      redirect_to politician_path(@politician)
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
