class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home welcome]
  @@quote_just_voted_on = nil

  def welcome
    @locations = Location.all
    render 'home' if user_signed_in?
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
    if !@@quote_just_voted_on.nil?
      @quote_just_voted_on = @@quote_just_voted_on
      @@quote_just_voted_on = nil
    end

    # redirect_to new_quote_vote_path(@random_not_voted_quote) unless @random_not_voted_quote.nil?
  end

  def cast_vote
    @vote = Vote.new(params[:id])
    @vote.user = current_user
    @vote.content = params[:content].to_i # somehow integers passed as string via http
    @quote = Quote.find(params[:quote_id])
    @vote.quote = @quote
    @@quote_just_voted_on = @quote

    if @vote.save
      flash[:success] = 'Object successfully updated'
      redirect_to quiz_path
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  # def cast_vote
  #   vote = Vote.new
  #   vote.user = current_user
  # end
end
