class MoviesController < ApplicationController
  def index
    @movies = Movie.all.order('created_at DESC')
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews
  end

end
