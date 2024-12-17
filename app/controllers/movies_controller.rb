class MoviesController < ApplicationController
  def new
    @movie = Movie.new
  end

  def index
    @list_of_movies = Movie.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @list_of_movies
      end

      format.html
    end
  end

  def show
    @the_movie = Movie.where(id: params.fetch(:id)).first
    render "movies/show"
  end

  def create
    movie_attributes = params.require(:movie).permit(:title, :description)
    @movie = Movie.new(movie_attributes)

    if @movie.valid?
      @movie.save
      redirect_to movies_url, notice: "Movie created successfully."
    else
      render "movies/new"
    end
  end

  def edit
    @the_movie = Movie.where(id: params.fetch(:id)).first

    render "movies/edit"
  end

  def update
    the_id = params.fetch(:id)
    the_movie = Movie.where(id: the_id).first

    the_movie.title = params.fetch("query_title")
    the_movie.description = params.fetch("query_description")

    if the_movie.valid?
      the_movie.save
      redirect_to "/movies/#{the_movie.id}", notice: "Movie created successfully."
    else
      redirect_to "/movies/#{the_movie.id}", alert: "Movie failed to update successfully."
    end
  end

  def destroy
    the_movie = Movie.where(id: params.fetch(:id)).first
    the_movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
