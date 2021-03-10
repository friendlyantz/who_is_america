class VotesController < ApplicationController
  def new
    @quote = Quote.find(params[:quote_id]) 
    @vote = Vote.new
  end
  
  def create
    @vote = Vote.new(params[:id])
    @vote.user = current_user
    @vote.content = params[:content]
    @quote = Quote.find(params[:quote_id])
    @vote.quote = @quote

    if @vote.save
      flash[:success] = 'Object successfully updated'
      redirect_to quiz_path
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end

  end

  private

  # def vote_params
  #   params.require(:vote).permit(:content, :quote_id)
  # end
  
end
