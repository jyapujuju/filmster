class MovieBuilder
  def initialize(imdbid)
    @imdbid = imdbid
    @movie = Movie.find_or_initialize_by(imdbid: @imdbid)
  end
  def build!
    if @movie.new_record?
      @fetched_movie =Omdb::Api.find_by(id:@imdbid)

      @movie.title = @fetched_movie.title
      @movie.year = @fetched_movie.year
      @movie.rated = @fetched_movie.rated
      @movie.released = @fetched_movie.released
      @movie.runtime = @fetched_movie.runtime
      @movie.genre = @fetched_movie.genre
      @movie.director = @fetched_movie.director
      @movie.writer = @fetched_movie.writer
      @movie.actors = @fetched_movie.actors
      @movie.plot = @fetched_movie.plot
      @movie.language = @fetched_movie.language
      @movie.country = @fetched_movie.country
      @movie.awards = @fetched_movie.awards
      @movie.poster = @fetched_movie.poster
      @movie.metascore = @fetched_movie.metascore
      @movie.imdbrating = @fetched_movie.imdbrating
      @movie.imdbvotes = @fetched_movie.imdbvotes
      @movie.imdbid = @fetched_movie.imdbid
    end
    @movie.save!
    return @movie
  end
end
