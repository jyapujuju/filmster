class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = MovieBuilder.new(imdbid: params[:imdbid]).build!

      @review = current_user.review.new(review_params.merge(movie: @movie))
      if @review.save
        flash[:success] = "review saved!"
        redirect_to root_path
      else
        flash[:alert] = "woops! It seems there was an error."
        redirect_to root_path
      end
  end

  def show
    @movie = Movie.all.order('created_at DESC')
  end

  private

  def review_params
    params.require(:review).permit(:comment)
  end

end
