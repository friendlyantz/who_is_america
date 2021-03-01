class QuotesController < ApplicationController
  def index
    @quotes = Quote.all
  end

  def new
    @quote = Quote.new
    @politicians = Politician.all
  end

  def create
    @quote = Quote.new(quote_params)
    # debug
    # @politician = Politician.find(params[:politician_id])
    # @quote.politician = @politician
    @quote.creator = current_user

    if @quote.save
      flash[:success] = 'Object successfully created'
      redirect_to contribute_path
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end
  
  def edit
    @quote = Quote.find(params[:id])
  end
  
  def update
    @quote = Quote.find(params[:id])
    if @quote.update(quote_params)
      flash[:success] = 'Object successfully updated'
      redirect_to contribute_path
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end
 

  private

  def quote_params
    params.require(:quote).permit(:content, :source_link, :politician_id, :source_tracker_id)
  end
end
