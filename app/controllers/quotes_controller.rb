class QuotesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # @quotes = Quote.all
    @quotes = policy_scope(Quote)

  end

  def new
    @quote = Quote.new
    authorize @quote 
    @politicians = Politician.all
  end
  
  def create
    @quote = Quote.new(quote_params)
    authorize @quote 
    # debug
    # @politician = Politician.find(params[:politician_id])
    # @quote.politician = @politician
    @quote.creator = current_user
    
    if @quote.save
      flash[:notice] = 'Object successfully created'
      redirect_to contribute_path
    else
      flash[:alert] = 'Something went wrong'
      render 'new'
    end
  end
  
  def edit
    @quote = Quote.find(params[:id])
    authorize @quote 
  end
  
  def update
    @quote = Quote.find(params[:id])
    authorize @quote 
    if @quote.update(quote_params)
      flash[:notice] = 'Object successfully updated'
      redirect_to contribute_path
    else
      flash[:alert] = 'Something went wrong'
      render 'edit'
    end
  end
  
  
  private
  
  def quote_params
    params.require(:quote).permit(:content, :source_link, :politician_id, :source_tracker_id)
  end
end
